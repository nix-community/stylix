{ mkTarget, ... }:
mkTarget {
  config = { colors, polarity }:
    let
      isLight = polarity == "light";

      # OpenCode themes have a "dark" variant (used when the terminal is dark)
      # and a "light" variant (used when the terminal is light).
      #
      # The base16 mapping below assumes dark polarity (base00 = dark bg).
      # For light-polarity schemes (base00 = light bg), the assignments are
      # backwards, so we swap them.
      mkColor = darkColor: lightColor:
        if isLight then {
          dark = lightColor;
          light = darkColor;
        } else {
          dark = darkColor;
          light = lightColor;
        };
    in {
      programs.opencode = let theme = "stylix";
      in {
        settings = { inherit theme; };
        themes.${theme} = {
          theme = {
            accent =
              mkColor colors.withHashtag.base0F colors.withHashtag.base07;
            background =
              mkColor colors.withHashtag.base00 colors.withHashtag.base06;
            backgroundElement =
              mkColor colors.withHashtag.base01 colors.withHashtag.base04;
            backgroundPanel =
              mkColor colors.withHashtag.base01 colors.withHashtag.base05;
            border =
              mkColor colors.withHashtag.base02 colors.withHashtag.base03;
            borderActive =
              mkColor colors.withHashtag.base03 colors.withHashtag.base02;
            borderSubtle =
              mkColor colors.withHashtag.base02 colors.withHashtag.base03;
            diffAdded =
              mkColor colors.withHashtag.base0B colors.withHashtag.base0B;
            diffAddedBg =
              mkColor colors.withHashtag.base01 colors.withHashtag.base05;
            diffAddedLineNumberBg =
              mkColor colors.withHashtag.base01 colors.withHashtag.base05;
            diffContext =
              mkColor colors.withHashtag.base03 colors.withHashtag.base03;
            diffContextBg =
              mkColor colors.withHashtag.base01 colors.withHashtag.base05;
            diffHighlightAdded =
              mkColor colors.withHashtag.base0B colors.withHashtag.base0B;
            diffHighlightRemoved =
              mkColor colors.withHashtag.base08 colors.withHashtag.base08;
            diffHunkHeader =
              mkColor colors.withHashtag.base03 colors.withHashtag.base03;
            diffLineNumber =
              mkColor colors.withHashtag.base03 colors.withHashtag.base04;
            diffRemoved =
              mkColor colors.withHashtag.base08 colors.withHashtag.base08;
            diffRemovedBg =
              mkColor colors.withHashtag.base01 colors.withHashtag.base05;
            diffRemovedLineNumberBg =
              mkColor colors.withHashtag.base01 colors.withHashtag.base05;
            error = mkColor colors.withHashtag.base08 colors.withHashtag.base08;
            info = mkColor colors.withHashtag.base0C colors.withHashtag.base0F;
            markdownBlockQuote =
              mkColor colors.withHashtag.base03 colors.withHashtag.base01;
            markdownCode =
              mkColor colors.withHashtag.base0B colors.withHashtag.base0B;
            markdownCodeBlock =
              mkColor colors.withHashtag.base01 colors.withHashtag.base00;
            markdownEmph =
              mkColor colors.withHashtag.base0A colors.withHashtag.base09;
            markdownHeading =
              mkColor colors.withHashtag.base0E colors.withHashtag.base0F;
            markdownHorizontalRule =
              mkColor colors.withHashtag.base04 colors.withHashtag.base03;
            markdownImage =
              mkColor colors.withHashtag.base0D colors.withHashtag.base0D;
            markdownImageText =
              mkColor colors.withHashtag.base0C colors.withHashtag.base07;
            markdownLink =
              mkColor colors.withHashtag.base0D colors.withHashtag.base0D;
            markdownLinkText =
              mkColor colors.withHashtag.base0C colors.withHashtag.base07;
            markdownListEnumeration =
              mkColor colors.withHashtag.base0C colors.withHashtag.base07;
            markdownListItem =
              mkColor colors.withHashtag.base0D colors.withHashtag.base0F;
            markdownStrong =
              mkColor colors.withHashtag.base09 colors.withHashtag.base0A;
            markdownText =
              mkColor colors.withHashtag.base05 colors.withHashtag.base00;
            primary =
              mkColor colors.withHashtag.base0D colors.withHashtag.base0F;
            secondary =
              mkColor colors.withHashtag.base0E colors.withHashtag.base0D;
            success =
              mkColor colors.withHashtag.base0B colors.withHashtag.base0B;
            syntaxComment =
              mkColor colors.withHashtag.base04 colors.withHashtag.base03;
            syntaxFunction =
              mkColor colors.withHashtag.base0D colors.withHashtag.base0C;
            syntaxKeyword =
              mkColor colors.withHashtag.base0E colors.withHashtag.base0D;
            syntaxNumber =
              mkColor colors.withHashtag.base09 colors.withHashtag.base0E;
            syntaxOperator =
              mkColor colors.withHashtag.base0C colors.withHashtag.base0D;
            syntaxPunctuation =
              mkColor colors.withHashtag.base05 colors.withHashtag.base00;
            syntaxString =
              mkColor colors.withHashtag.base0B colors.withHashtag.base0B;
            syntaxType =
              mkColor colors.withHashtag.base0A colors.withHashtag.base07;
            syntaxVariable =
              mkColor colors.withHashtag.base07 colors.withHashtag.base07;
            text = mkColor colors.withHashtag.base05 colors.withHashtag.base00;
            textMuted =
              mkColor colors.withHashtag.base04 colors.withHashtag.base01;
            warning =
              mkColor colors.withHashtag.base0A colors.withHashtag.base0A;
          };
        };
      };
    };
}
