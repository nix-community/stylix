{
  perSystem =
    {
      config,
      inputs',
      lib,
      pkgs,
      ...
    }:
    let
      stylix-check = pkgs.writeShellApplication {
        name = "stylix-check";
        runtimeInputs = with pkgs; [
          calc
          nix-fast-build
        ];

        # TODO: Implement proper CLI parsing and handling.
        #
        # TODO: Consider using 'nice' by default to avoid borking user systems.
        #       This could be disabled in /.github/workflows/check.yml.
        text = ''
          if ${lib.boolToString pkgs.stdenv.hostPlatform.isLinux}; then
            memory="$(free --mega | awk '/^Mem:/ { print $2 }')"
          else
            memory=512
          fi

          memory="$(calc "round($memory * ''${1:-.75})")"

          memory_per_worker=$((memory / NIX_BUILD_CORES))

          workers="$((
            NIX_BUILD_CORES < memory_per_worker ?
            NIX_BUILD_CORES :
            memory_per_worker
          ))"

          memory_per_worker="$((memory / workers))"

          nix-fast-build \
            --eval-max-memory-size "$memory_per_worker" \
            --eval-workers "$workers" \
            --no-link \
            --skip-cached \
            "''${@:2}"
        '';
      };

      # The shell should not directly depend on `packages.serve-docs`, because
      # that'd build the docs before entering the shell. Instead, we want to
      # build the docs only when running 'serve-docs'.
      #
      # For a similar reason, we can't use `self` as a reference to the flake:
      # `self` represents the flake as it was when the devshell was evaluated,
      # not the local flake worktree that has possibly been modified since
      # entering the devshell.
      build-and-run-docs = pkgs.writeShellScriptBin "serve-docs" ''
        nix run .#doc
      '';
    in
    {
      devShells = {
        default = pkgs.mkShell {
          # Install git-hooks when activating the shell
          shellHook = config.pre-commit.installationScript;

          packages =
            [
              stylix-check
              build-and-run-docs
              inputs'.home-manager.packages.default
              config.formatter
            ]
            ++ config.pre-commit.settings.enabledPackages
            ++ config.formatter.runtimeInputs;
        };

        ghc = pkgs.mkShell {
          inputsFrom = [ config.devShells.default ];
          packages = [ pkgs.ghc ];
        };
      };
    };
}
