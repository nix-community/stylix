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
      generators.semantic = config.lib.stylix.generators.semantic.matugen { };
      mappingFunction = config.lib.stylix.mappings.semantic2base16;
    };
  };
}
