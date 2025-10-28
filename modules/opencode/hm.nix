{ mkTarget, ... }:
mkTarget {
  name = "opencode";
  humanName = "OpenCode";

  configElements =
    { colors }:
    {
      programs.opencode =
        let
          theme = "stylix";
        in
        {
          settings = { inherit theme; };
          themes.${theme} = {
            theme = {
              accent = {
                dark = colors.withHashtag.base07;
                light = colors.withHashtag.base07;
              };
              background = {
                dark = colors.withHashtag.base00;
                light = colors.withHashtag.base06;
              };
              backgroundElement = {
                dark = colors.withHashtag.base01;
                light = colors.withHashtag.base04;
              };
              backgroundPanel = {
                dark = colors.withHashtag.base01;
                light = colors.withHashtag.base05;
              };
              border = {
                dark = colors.withHashtag.base02;
                light = colors.withHashtag.base03;
              };
              borderActive = {
                dark = colors.withHashtag.base03;
                light = colors.withHashtag.base02;
              };
              borderSubtle = {
                dark = colors.withHashtag.base02;
                light = colors.withHashtag.base03;
              };
              diffAdded = {
                dark = colors.withHashtag.base0B;
                light = colors.withHashtag.base0B;
              };
              diffAddedBg = {
                dark = colors.withHashtag.base01;
                light = colors.withHashtag.base05;
              };
              diffAddedLineNumberBg = {
                dark = colors.withHashtag.base01;
                light = colors.withHashtag.base05;
              };
              diffContext = {
                dark = colors.withHashtag.base03;
                light = colors.withHashtag.base03;
              };
              diffContextBg = {
                dark = colors.withHashtag.base01;
                light = colors.withHashtag.base05;
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
                dark = colors.withHashtag.base02;
                light = colors.withHashtag.base04;
              };
              diffRemoved = {
                dark = colors.withHashtag.base08;
                light = colors.withHashtag.base08;
              };
              diffRemovedBg = {
                dark = colors.withHashtag.base01;
                light = colors.withHashtag.base05;
              };
              diffRemovedLineNumberBg = {
                dark = colors.withHashtag.base01;
                light = colors.withHashtag.base05;
              };
              error = {
                dark = colors.withHashtag.base08;
                light = colors.withHashtag.base08;
              };
              info = {
                dark = colors.withHashtag.base0C;
                light = colors.withHashtag.base0F;
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
                dark = colors.withHashtag.base04;
                light = colors.withHashtag.base00;
              };
              markdownEmph = {
                dark = colors.withHashtag.base09;
                light = colors.withHashtag.base09;
              };
              markdownHeading = {
                dark = colors.withHashtag.base0C;
                light = colors.withHashtag.base0F;
              };
              markdownHorizontalRule = {
                dark = colors.withHashtag.base03;
                light = colors.withHashtag.base03;
              };
              markdownImage = {
                dark = colors.withHashtag.base0D;
                light = colors.withHashtag.base0D;
              };
              markdownImageText = {
                dark = colors.withHashtag.base07;
                light = colors.withHashtag.base07;
              };
              markdownLink = {
                dark = colors.withHashtag.base0D;
                light = colors.withHashtag.base0D;
              };
              markdownLinkText = {
                dark = colors.withHashtag.base07;
                light = colors.withHashtag.base07;
              };
              markdownListEnumeration = {
                dark = colors.withHashtag.base07;
                light = colors.withHashtag.base07;
              };
              markdownListItem = {
                dark = colors.withHashtag.base0C;
                light = colors.withHashtag.base0F;
              };
              markdownStrong = {
                dark = colors.withHashtag.base0A;
                light = colors.withHashtag.base0A;
              };
              markdownText = {
                dark = colors.withHashtag.base04;
                light = colors.withHashtag.base00;
              };
              primary = {
                dark = colors.withHashtag.base0C;
                light = colors.withHashtag.base0F;
              };
              secondary = {
                dark = colors.withHashtag.base0D;
                light = colors.withHashtag.base0D;
              };
              success = {
                dark = colors.withHashtag.base0B;
                light = colors.withHashtag.base0B;
              };
              syntaxComment = {
                dark = colors.withHashtag.base03;
                light = colors.withHashtag.base03;
              };
              syntaxFunction = {
                dark = colors.withHashtag.base0C;
                light = colors.withHashtag.base0C;
              };
              syntaxKeyword = {
                dark = colors.withHashtag.base0D;

                light = colors.withHashtag.base0D;

              };
              syntaxNumber = {
                dark = colors.withHashtag.base0E;
                light = colors.withHashtag.base0E;
              };
              syntaxOperator = {
                dark = colors.withHashtag.base0D;
                light = colors.withHashtag.base0D;
              };
              syntaxPunctuation = {
                dark = colors.withHashtag.base04;
                light = colors.withHashtag.base00;
              };
              syntaxString = {
                dark = colors.withHashtag.base0B;
                light = colors.withHashtag.base0B;
              };
              syntaxType = {
                dark = colors.withHashtag.base07;
                light = colors.withHashtag.base07;
              };
              syntaxVariable = {
                dark = colors.withHashtag.base07;
                light = colors.withHashtag.base07;
              };
              text = {
                dark = colors.withHashtag.base04;
                light = colors.withHashtag.base00;
              };
              textMuted = {
                dark = colors.withHashtag.base03;
                light = colors.withHashtag.base01;
              };
              warning = {
                dark = colors.withHashtag.base09;
                light = colors.withHashtag.base09;
              };
            };
          };
        };
    };
}
