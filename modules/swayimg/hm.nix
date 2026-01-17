{
  mkTarget,
  lib,
  config,
  ...
}:
mkTarget {
  name = "swayimg";
  humanName = "Swayimg";

  configElements =
    { colors, opacity }:
    with colors.withHashtag;
    let
      swayimgOpacity = lib.toHexString (
        builtins.floor (opacity.applications * 100 + 0.5) * 255 / 100
      );
    in
    {
      programs.swayimg.settings = {
        viewer = {
          window = base00 + swayimgOpacity;
        };
        slideshow = {
          transparency = "#000000ff";
        };
        gallery = {
          window = base00 + swayimgOpacity;
          background = "#00000000";
          select = base0D;
          border = base0D;
          shadow = "#00000000";
        };
        font =
          with config.stylix.fonts.monospace;
          with config.stylix.fonts.sizes;
          {
            inherit name;
            size = applications;
            color = base05;
            shadow = "#000000d0";
            background = "#00000000";
          };
      };
    };
}
