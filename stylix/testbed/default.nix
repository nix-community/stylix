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
          # keep-sorted start
          ./modules/application.nix
          ./modules/common.nix
          ./modules/enable.nix
          inputs.home-manager.nixosModules.home-manager
          inputs.self.nixosModules.stylix
          testbed
          # keep-sorted end
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
