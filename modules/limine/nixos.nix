{
  mkTarget,
  config,
  lib,
  ...
}:
mkTarget {
  name = "Limine";
  humanName = "Limine";

  extraOptions.useWallpaper = config.lib.stylix.mkEnableWallpaper "Limine" true;

  configElements = [
    (
      { colors }:
      {
        boot.loader.limine =
          with colors;
          lib.mkIf (config.stylix.enable && cfg.enable) {
            style = {
              graphicalTerminal = {
                palette = "${base05};${base08};${base0B};${base0A};${base0D};${base0E};${base0C};${base00}";
                brightPalette = "${base00};${base08};${base0B};${base0A};${base0D};${base0E};${base0C};${base05}";
                background = base00;
                foreground = base05;
                brightBackground = base05;
                brightForeground = base0A;
              };
            };
          };
      }
    )
    (
      { cfg, image }:
      {

        boot.loader.limine.style.wallpapers = lib.mkIf cfg.useWallpaper [
          image
        ];
      }
    )
  ];
}
