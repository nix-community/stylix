{ pkgs, config, ... }:
let
  inherit (config.stylix.inputs) tinted-schemes;
in
{
  stylix = {
    enable = true;
    palette.manual.base16 = "${tinted-schemes}/base16/catppuccin-macchiato.yaml";
    polarity = "dark";
    cursor = {
      name = "Vanilla-DMZ";
      package = pkgs.vanilla-dmz;
      size = 32;
    };
  };
}
