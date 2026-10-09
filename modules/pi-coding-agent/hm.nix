{ mkTarget, ... }:
mkTarget {
  config = { colors }: {
    programs.pi-coding-agent.settings.theme = "stylix";

    home.file.".pi/agent/themes/stylix.json".text = builtins.toJSON {
      "$schema" =
        "https://raw.githubusercontent.com/earendil-works/pi/main/packages/coding-agent/src/modes/interactive/theme/theme-schema.json";
      name = "stylix";
      colors = with colors.withHashtag; {
        accent = base0D;
        border = base03;
        borderAccent = base0D;
        borderMuted = base02;
        success = base0B;
        error = base08;
        warning = base0A;
        muted = base04;
        dim = base03;
        text = "";
        thinkingText = base04;

        selectedBg = base02;
        userMessageBg = base01;
        userMessageText = "";
        customMessageBg = base01;
        customMessageText = "";
        customMessageLabel = base0D;
        toolPendingBg = base00;
        toolSuccessBg = base01;
        toolErrorBg = base01;
        toolTitle = base0D;
        toolOutput = "";

        mdHeading = base0E;
        mdLink = base0D;
        mdLinkUrl = base0C;
        mdCode = base0B;
        mdCodeBlock = "";
        mdCodeBlockBorder = base03;
        mdQuote = base04;
        mdQuoteBorder = base03;
        mdHr = base03;
        mdListBullet = base0C;

        toolDiffAdded = base0B;
        toolDiffRemoved = base08;
        toolDiffContext = base04;

        syntaxComment = base03;
        syntaxKeyword = base0E;
        syntaxFunction = base0D;
        syntaxVariable = base08;
        syntaxString = base0B;
        syntaxNumber = base09;
        syntaxType = base0A;
        syntaxOperator = base0C;
        syntaxPunctuation = base05;

        thinkingOff = base03;
        thinkingMinimal = base0D;
        thinkingLow = base0C;
        thinkingMedium = base0B;
        thinkingHigh = base0A;
        thinkingXhigh = base09;
        thinkingMax = base08;

        bashMode = base0A;
      };
    };
  };
}
