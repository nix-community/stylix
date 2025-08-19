{ pkgs, ... }:
let
  images = pkgs.callPackages ../images.nix { };
in
{
  stylix = {
    enable = true;
    image = images.dark;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
    polarity = "dark";
    cursor = {
      name = "Vanilla-DMZ";
      package = pkgs.vanilla-dmz;
      size = 32;
    };
  };
}
