{
  config,
  lib,
  mkTarget,
  options,
  pkgs,
  ...
}:
let
  inherit (lib) fixedWidthString toHexString;

  jsonFormat = pkgs.formats.json { };

  hasPiCodingAgent = options.programs ? pi-coding-agent;
in
mkTarget {
  autoEnable = hasPiCodingAgent && config.programs.pi-coding-agent.enable;
  autoEnableExpr = "options.programs ? pi-coding-agent && config.programs.pi-coding-agent.enable";

  config = lib.optionals hasPiCodingAgent [
    (
      { colors }:
      let
        hex = name: "#${colors.${name}}";

        base = hex "base00";
        surface = hex "base01";
        surfaceAlt = hex "base02";
        overlay = hex "base03";
        muted = hex "base04";
        text = hex "base05";
        textAlt = hex "base06";
        textBright = hex "base07";

        red = hex "base08";
        orange = hex "base09";
        yellow = hex "base0A";
        green = hex "base0B";
        cyan = hex "base0C";
        blue = hex "base0D";
        purple = hex "base0E";
        brown = hex "base0F";

        # One channel of the base16 colour `«name»`, as a float between
        # 0 and 1.
        channel = name: axis: builtins.fromJSON colors."${name}-dec-${axis}";

        # Mix two base16 colours in sRGB space, `weight` being the share
        # of `to`.
        mix =
          weight: from: to:
          let
            hex =
              axis:
              fixedWidthString 2 "0" (
                toHexString (
                  builtins.floor (
                    255.0 * ((1.0 - weight) * channel from axis + weight * channel to axis)
                  )
                )
              );
          in
          "#${hex "r"}${hex "g"}${hex "b"}";

        # Perceived brightness of a base16 colour, from 0 to 1.
        brightness =
          name:
          0.2126 * channel name "r"
          + 0.7152 * channel name "g"
          + 0.0722 * channel name "b";

        selected = mix 0.14 "base02" "base0D";
        userBg = mix 0.04 "base01" "base05";
        customBg = mix 0.10 "base01" "base0E";
        pendingBg = mix 0.10 "base01" "base0C";
        successBg = mix 0.12 "base01" "base0B";
        errorBg = mix 0.12 "base01" "base08";
        exportInfoBg = mix 0.12 "base01" "base0A";

        theme = {
          "$schema" =
            "https://raw.githubusercontent.com/earendil-works/pi/main/packages/coding-agent/src/modes/interactive/theme/theme-schema.json";
          name = "stylix";

          # Pi has to be told whether the scheme is light or dark.
          # `stylix.polarity` cannot answer that, as it is only a hint to
          # the palette generator and defaults to `either`.
          appearance =
            if brightness "base00" < brightness "base05" then "dark" else "light";

          vars = {
            inherit
              base
              surface
              surfaceAlt
              overlay
              muted
              text
              textAlt
              textBright
              red
              orange
              yellow
              green
              cyan
              blue
              purple
              brown
              selected
              userBg
              customBg
              pendingBg
              successBg
              errorBg
              ;
          };

          colors = {
            accent = "blue";
            border = "overlay";
            borderAccent = "blue";
            borderMuted = "muted";
            success = "green";
            error = "red";
            warning = "yellow";
            muted = "muted";
            dim = "overlay";
            text = "text";
            thinkingText = "muted";

            selectedBg = "selected";
            userMessageBg = "userBg";
            userMessageText = "text";
            customMessageBg = "customBg";
            customMessageText = "text";
            customMessageLabel = "purple";
            toolPendingBg = "pendingBg";
            toolSuccessBg = "successBg";
            toolErrorBg = "errorBg";
            toolTitle = "text";
            toolOutput = "muted";

            mdHeading = "yellow";
            mdLink = "blue";
            mdLinkUrl = "muted";
            mdCode = "cyan";
            mdCodeBlock = "text";
            mdCodeBlockBorder = "overlay";
            mdQuote = "muted";
            mdQuoteBorder = "overlay";
            mdHr = "overlay";
            mdListBullet = "cyan";

            toolDiffAdded = "green";
            toolDiffRemoved = "red";
            toolDiffContext = "muted";

            syntaxComment = "muted";
            syntaxKeyword = "purple";
            syntaxFunction = "blue";
            syntaxVariable = "red";
            syntaxString = "green";
            syntaxNumber = "orange";
            syntaxType = "yellow";
            syntaxOperator = "text";
            syntaxPunctuation = "muted";

            thinkingOff = "overlay";
            thinkingMinimal = "muted";
            thinkingLow = "cyan";
            thinkingMedium = "blue";
            thinkingHigh = "purple";
            thinkingXhigh = "red";
            thinkingMax = "orange";

            bashMode = "yellow";
          };

          export = {
            pageBg = base;
            cardBg = surface;
            infoBg = exportInfoBg;
          };
        };
      in
      {
        home.file."${config.programs.pi-coding-agent.configDir}/themes/stylix.json".source =
          jsonFormat.generate "pi-coding-agent-theme-stylix.json" theme;

        programs.pi-coding-agent.settings.theme = "stylix";
      }
    )
  ];
}
