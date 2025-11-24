{ pkgs, ... }:
let
  images = pkgs.callPackages ../images.nix { };
in
{
  stylix = {
    enable = true;
    image = images.dark;
    base16Scheme = (import ../color-schemes.nix).catppuccin-macchiato;
    polarity = "dark";
  };
}
