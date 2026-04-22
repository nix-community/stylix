{ mkTarget, lib, ... }:
mkTarget {
  options.opacity' = lib.mkOption {
    type = lib.types.str;
    internal = true;
    default = "";
  };

  config = [
    (
      { cfg, colors }:
      with colors.withHashtag;
      {
        programs.swayimg.settings = {
          viewer.window = base00 + cfg.opacity';
          slideshow.transparency = "#00000000";

          gallery = {
            window = base00 + cfg.opacity';
            background = "#00000000";
            select = base0D;
            border = base0D;
            shadow = "#00000000";
          };

          font = {
            color = base05;
            border = base0D;
            shadow = "#00000000";
            background = "#00000000";
          };
        };
      }
    )
    (
      { opacity }:
      {
        stylix.targets.swayimg.opacity' = lib.toHexString (
          builtins.floor (opacity.applications * 100 + 0.5) * 255 / 100
        );
      }
    )
    (
      { fonts }:
      {
        programs.swayimg.settings.font = {
          inherit (fonts.monospace) name;
          size = fonts.sizes.applications;
        };
      }
    )
  ];
}
