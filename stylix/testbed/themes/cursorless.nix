{ pkgs, config, ... }:
let
  images = pkgs.callPackages ../images.nix { };
  inherit (config.stylix.inputs) tinted-schemes;
in
{
  stylix = {
    enable = true;
    image = images.dark;
    palette.manual.base16 = "${tinted-schemes}/base16/catppuccin-macchiato.yaml";
    polarity = "dark";
  };
}
