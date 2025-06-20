{
  pkgs,
  inputs,
  lib,
  modules ? import ./autoload.nix { inherit pkgs lib; },
}:

let
  makeTestbed =
    name: testbed:
    let

      system = lib.nixosSystem {
        inherit (pkgs) system;

        modules = [
          ./modules/common.nix
          ./modules/enable.nix
          ./modules/application.nix
          inputs.self.nixosModules.stylix
          inputs.home-manager.nixosModules.home-manager
          testbed
        ];
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
