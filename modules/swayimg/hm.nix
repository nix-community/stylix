{ mkTarget, lib, ... }:
mkTarget {
  name = "swayimg";
  humanName = "Swayimg";

  configElements = [
    (
      { cfg, colors }:
      with colors.withHashtag;
      {
        programs.swayimg.settings = {
          viewer = {
            window = base00 + cfg.opacity;
          };
          slideshow = {
            transparency = "#00000000";
          };
          gallery = {
            window = base00 + cfg.opacity;
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
      { cfg, opacity }:
      let
        swayimgOpacity = lib.toHexString (
          builtins.floor (opacity.applications * 100 + 0.5) * 255 / 100
        );
      in
      {
        cfg.opacity = swayimgOpacity;
      }
    )

    (
      { fonts }:
      with fonts.monospace;
      with fonts.sizes;
      {
        programs.swayimg.settings.font = {
          inherit name;
          size = applications;
        };
      }
    )
  ];
}
