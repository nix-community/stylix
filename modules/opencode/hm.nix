{ mkTarget, ... }:
mkTarget {
  config =
    { colors }:
    {
      programs.opencode =
        let
          theme = "stylix";
        in
        {
          tui = { inherit theme; };
          themes.${theme} = {
            theme = {
              accent = {
                dark = colors.withHashtag.base0F;
                light = colors.withHashtag.base0F;
              };
              background = {
                dark = colors.withHashtag.base00;
                light = colors.withHashtag.base00;
              };
              backgroundElement = {
                dark = colors.withHashtag.base01;
                light = colors.withHashtag.base01;
              };
              backgroundPanel = {
                dark = colors.withHashtag.base01;
                light = colors.withHashtag.base01;
              };
              border = {
                dark = colors.withHashtag.base02;
                light = colors.withHashtag.base02;
              };
              borderActive = {
                dark = colors.withHashtag.base03;
                light = colors.withHashtag.base03;
              };
              borderSubtle = {
                dark = colors.withHashtag.base02;
                light = colors.withHashtag.base02;
              };
              diffAdded = {
                dark = colors.withHashtag.base0B;
                light = colors.withHashtag.base0B;
              };
              diffAddedBg = {
                dark = colors.withHashtag.base01;
                light = colors.withHashtag.base01;
              };
              diffAddedLineNumberBg = {
                dark = colors.withHashtag.base01;
                light = colors.withHashtag.base01;
              };
              diffContext = {
                dark = colors.withHashtag.base03;
                light = colors.withHashtag.base03;
              };
              diffContextBg = {
                dark = colors.withHashtag.base01;
                light = colors.withHashtag.base01;
              };
              diffHighlightAdded = {
                dark = colors.withHashtag.base0B;
                light = colors.withHashtag.base0B;
              };
              diffHighlightRemoved = {
                dark = colors.withHashtag.base08;
                light = colors.withHashtag.base08;
              };
              diffHunkHeader = {
                dark = colors.withHashtag.base03;
                light = colors.withHashtag.base03;
              };
              diffLineNumber = {
                dark = colors.withHashtag.base03;
                light = colors.withHashtag.base03;
              };
              diffRemoved = {
                dark = colors.withHashtag.base08;
                light = colors.withHashtag.base08;
              };
              diffRemovedBg = {
                dark = colors.withHashtag.base01;
                light = colors.withHashtag.base01;
              };
              diffRemovedLineNumberBg = {
                dark = colors.withHashtag.base01;
                light = colors.withHashtag.base01;
              };
              error = {
                dark = colors.withHashtag.base08;
                light = colors.withHashtag.base08;
              };
              info = {
                dark = colors.withHashtag.base0C;
                light = colors.withHashtag.base0C;
              };
              markdownBlockQuote = {
                dark = colors.withHashtag.base03;
                light = colors.withHashtag.base03;
              };
              markdownCode = {
                dark = colors.withHashtag.base0B;
                light = colors.withHashtag.base0B;
              };
              markdownCodeBlock = {
                dark = colors.withHashtag.base01;
                light = colors.withHashtag.base01;
              };
              markdownEmph = {
                dark = colors.withHashtag.base0A;
                light = colors.withHashtag.base0A;
              };
              markdownHeading = {
                dark = colors.withHashtag.base0E;
                light = colors.withHashtag.base0E;
              };
              markdownHorizontalRule = {
                dark = colors.withHashtag.base04;
                light = colors.withHashtag.base04;
              };
              markdownImage = {
                dark = colors.withHashtag.base0D;
                light = colors.withHashtag.base0D;
              };
              markdownImageText = {
                dark = colors.withHashtag.base0C;
                light = colors.withHashtag.base0C;
              };
              markdownLink = {
                dark = colors.withHashtag.base0D;
                light = colors.withHashtag.base0D;
              };
              markdownLinkText = {
                dark = colors.withHashtag.base0C;
                light = colors.withHashtag.base0C;
              };
              markdownListEnumeration = {
                dark = colors.withHashtag.base0C;
                light = colors.withHashtag.base0C;
              };
              markdownListItem = {
                dark = colors.withHashtag.base0D;
                light = colors.withHashtag.base0D;
              };
              markdownStrong = {
                dark = colors.withHashtag.base09;
                light = colors.withHashtag.base09;
              };
              markdownText = {
                dark = colors.withHashtag.base05;
                light = colors.withHashtag.base05;
              };
              primary = {
                dark = colors.withHashtag.base0D;
                light = colors.withHashtag.base0D;
              };
              secondary = {
                dark = colors.withHashtag.base0E;
                light = colors.withHashtag.base0E;
              };
              success = {
                dark = colors.withHashtag.base0B;
                light = colors.withHashtag.base0B;
              };
              syntaxComment = {
                dark = colors.withHashtag.base04;
                light = colors.withHashtag.base04;
              };
              syntaxFunction = {
                dark = colors.withHashtag.base0D;
                light = colors.withHashtag.base0D;
              };
              syntaxKeyword = {
                dark = colors.withHashtag.base0E;
                light = colors.withHashtag.base0E;
              };
              syntaxNumber = {
                dark = colors.withHashtag.base09;
                light = colors.withHashtag.base09;
              };
              syntaxOperator = {
                dark = colors.withHashtag.base0C;
                light = colors.withHashtag.base0C;
              };
              syntaxPunctuation = {
                dark = colors.withHashtag.base05;
                light = colors.withHashtag.base05;
              };
              syntaxString = {
                dark = colors.withHashtag.base0B;
                light = colors.withHashtag.base0B;
              };
              syntaxType = {
                dark = colors.withHashtag.base0A;
                light = colors.withHashtag.base0A;
              };
              syntaxVariable = {
                dark = colors.withHashtag.base07;
                light = colors.withHashtag.base07;
              };
              text = {
                dark = colors.withHashtag.base05;
                light = colors.withHashtag.base05;
              };
              textMuted = {
                dark = colors.withHashtag.base04;
                light = colors.withHashtag.base04;
              };
              warning = {
                dark = colors.withHashtag.base0A;
                light = colors.withHashtag.base0A;
              };
            };
          };
        };
    };
}
