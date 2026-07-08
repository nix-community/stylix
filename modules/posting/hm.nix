{ mkTarget, ... }:
mkTarget {
  config = [
    (
      { colors }:
      let
        theme = {
          name = "stylix";
          primary = colors.withHashtag.base0D;
          secondary = colors.withHashtag.base0E;
          accent = colors.withHashtag.base09;
          background = colors.withHashtag.base00;
          surface = colors.withHashtag.base01;
          panel = colors.withHashtag.base03;
          warning = colors.withHashtag.base0A;
          error = colors.withHashtag.base08;
          success = colors.withHashtag.base0B;
          dark = true;
        };
      in
      {
        programs.posting = {
          themes."stylix" = theme;
          settings = {
            theme = "stylix";
            watch_themes = false;
          };
        };
      }
    )
  ];
}
