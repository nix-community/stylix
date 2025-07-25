{ pkgs, ... }:
let
  images = pkgs.callPackages ../images.nix { };
in
{
  stylix = {
    enable = true;
    image = images.dark;
    colorGeneration.polarity = "dark";
    cursor = {
      name = "Vanilla-DMZ";
      package = pkgs.vanilla-dmz;
      size = 32;
    };
  };
}
