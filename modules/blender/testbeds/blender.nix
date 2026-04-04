{ pkgs, ... }:
let
  package = pkgs.blender;
in
{
  stylix.testbed = {
    # TODO: Re-enable the aarch64-linux variant once the upstream build failure
    # [1] ("Build failure: blender (on aarch64-linux)") is resolved.
    #
    # [1]: https://github.com/NixOS/nixpkgs/issues/503387
    enable = pkgs.stdenv.hostPlatform.system != "aarch64-linux";

    ui.application = {
      name = "blender";
      inherit package;
    };
  };

  environment.systemPackages = [ package ];
}
