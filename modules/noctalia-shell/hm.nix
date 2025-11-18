{
  mkTarget,
  lib,
  options,
  ...
}:
mkTarget {
  config = lib.optionals (options.programs ? noctalia-shell) [
    (
      { colors }:
      {
        programs.noctalia-shell = {
          colors = with colors.withHashtag; {
            mPrimary = base05;
            mOnPrimary = base00;
            mSecondary = base05;
            mOnSecondary = base00;
            mTertiary = base04;
            mOnTertiary = base00;
            mError = base08;
            mOnError = base00;
            mSurface = base00;
            mOnSurface = base05;
            mHover = base04;
            mOnHover = base00;
            mSurfaceVariant = base01;
            mOnSurfaceVariant = base04;
            mOutline = base02;
            mShadow = base00;
          };
        };
      }
    )
    (
      { opacity }:
      {
        programs.noctalia-shell = {
          settings = {
            bar.backgroundOpacity = opacity.desktop;
            bar.capsuleOpacity = opacity.desktop;
            ui.panelBackgroundOpacity = opacity.desktop;
            dock.backgroundOpacity = opacity.desktop;
            osd.backgroundOpacity = opacity.popups;
            notifications.backgroundOpacity = opacity.popups;
          };
        };
      }
    )
    (
      { fonts }:
      {
        programs.noctalia-shell = {
          settings = {
            ui.fontDefault = fonts.sansSerif.name;
            ui.fontFixed = fonts.monospace.name;
          };
        };
      }
    )
    (
      { image }:
      {
        home.file.".cache/noctalia/wallpapers.json" = {
          text = builtins.toJSON { defaultWallpaper = image; };
        };
      }
    )
  ];
}
