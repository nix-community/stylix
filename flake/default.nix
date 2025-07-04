{
  imports = [
    ./deprecation
    ./dev-shell.nix
    ./modules.nix
    ./packages.nix
    ./pre-commit.nix
  ];

  perSystem =
    { pkgs, ... }:
    {
      # TODO: consider using https://flake.parts/options/treefmt-nix.html once
      # dev flake is partitioned
      formatter = pkgs.treefmt.withConfig {
        runtimeInputs = with pkgs; [
          # keep-sorted start
          biome
          keep-sorted
          nixfmt-rfc-style
          ruff
          stylish-haskell
          # keep-sorted end
        ];

        settings = {
          on-unmatched = "info";
          tree-root-file = "flake.nix";

          formatter = {
            # keep-sorted start block=yes
            biome = {
              command = "biome";
              options = [
                "format"
                "--write"
                "--no-errors-on-unmatched"
                "--config-path"
                (pkgs.writers.writeJSON "biome.json" {
                  formatter = {
                    indentStyle = "space";
                    indentWidth = 2;
                    lineWidth = 80;
                  };
                })
              ];
              includes = [
                "*.css"
                "*.js"
                "*.json"
              ];
              excludes = [
                # Contains custom syntax that biome can't handle
                "modules/swaync/base.css"
              ];
            };
            keep-sorted = {
              command = "keep-sorted";
              includes = [ "*" ];
            };
            nixfmt = {
              command = "nixfmt";
              options = [ "--width=80" ];
              includes = [ "*.nix" ];
            };
            ruff = {
              command = "ruff";
              options = [
                "--config"
                (pkgs.writers.writeTOML "ruff.toml" {
                  line-length = 80;
                })
                "format"
              ];
              includes = [ "*.py" ];
            };
            stylish-haskell = {
              command = "stylish-haskell";
              includes = [ "*.hx" ];
            };
            # keep-sorted end
          };
        };
      };
    };
}
