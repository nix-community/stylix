{ lib, ... }:

let
  autoload = import ../autoload.nix { inherit lib; } "droid";
in
{
  imports = [
    # keep-sorted start
    ../fonts.nix
    ../home-manager-integration.nix
    ../opacity.nix
    ../overlays.nix
    ../palette.nix
    ../pixel.nix
    ../target.nix
    # keep-sorted end
  ] ++ autoload;

  # See https://github.com/nix-community/nix-on-droid/issues/436
  options.lib = lib.mkOption {
    type = with lib.types; attrsOf attrs;
  };
}
