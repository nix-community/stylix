{ lib, ... }:
let
  autoload = import ../autoload.nix { inherit lib; } "droid";
in
{
  imports = [
    ./fonts.nix
    ./palette.nix
    ../home-manager-integration.nix
    ../opacity.nix
    ../pixel.nix
    ../target.nix
    ../overlays.nix
  ] ++ autoload;

  # See https://github.com/nix-community/nix-on-droid/issues/436
  options.lib = lib.mkOption {
    type = with lib.types; attrsOf attrs;
  };
}
