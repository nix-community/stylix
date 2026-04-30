{ pkgs, config, ... }:
let
  images = pkgs.callPackages ../images.nix { };
in
{
  stylix = {
    enable = true;
    image = images.light;
    polarity = "light";
    cursor = {
      name = "Vanilla-DMZ";
      package = pkgs.vanilla-dmz;
      size = 32;
    };
    palette = {
      generators.semantic = config.stylix.lib.generators.semantic.matugen { };
      mappingFunction = config.stylix.lib.mappings.semantic2base16;
    };
  };
}
