{
  pkgs,
  inputs,
  lib,
  modules ? import ./autoload.nix { inherit pkgs lib; },
  testbedFieldSeparator ? ":",
}:
let
  makeTestbed =
    name: testbed:
    let
      system = lib.nixosSystem {
        inherit (pkgs.stdenv.hostPlatform) system;

        modules = [
          (lib.modules.importApply ./modules/flake-parts.nix inputs)
          ./modules/common.nix
          ./modules/enable.nix
          ./modules/application.nix
          inputs.self.nixosModules.stylix
          inputs.home-manager.nixosModules.home-manager
          testbed
        ]
        ++ map (name: import ./graphical-environments/${name}.nix) (
          import ./available-graphical-environments.nix { inherit lib; }
        )
        ++
          lib.mapAttrsToList
            (
              target:
              lib.optionalAttrs (
                lib.hasPrefix "testbed${testbedFieldSeparator}${target}" name
              )
            )
            {
              inherit (inputs.spicetify-nix.nixosModules) spicetify;

              nixvim-integrated = inputs.nixvim.nixosModules.nixvim;

              nixvim-standalone.lib.stylix.testbed = {
                inherit (inputs.nixvim.legacyPackages.${pkgs.stdenv.hostPlatform.system})
                  makeNixvim
                  ;
              };

              noctalia-shell.home-manager.sharedModules = [
                inputs.noctalia-shell.homeModules.default
              ];

              nvf = inputs.nvf.nixosModules.default;

              vicinae.home-manager.sharedModules = [
                inputs.vicinae.homeManagerModules.default
              ];

              zen-browser.home-manager.sharedModules = [
                inputs.zen-browser.homeModules.default
              ];
            };
      };
    in
    pkgs.writeShellApplication {
      inherit name;
      text = ''
        cleanup() {
          if rm --recursive "$directory"; then
            printf '%s\n' 'Virtualisation disk image removed.'
          fi
        }

        # We create a temporary directory rather than a temporary file, since
        # temporary files are created empty and are not valid disk images.
        directory="$(mktemp --directory)"
        trap cleanup EXIT

        NIX_DISK_IMAGE="$directory/nixos.qcow2" \
          ${lib.getExe system.config.system.build.vm}
      '';
    };
in
builtins.mapAttrs makeTestbed modules
