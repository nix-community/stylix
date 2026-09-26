{
  config,
  lib,
  mkTarget,
  options,
  pkgs,
  ...
}:
let
  inherit (lib)
    fixedWidthString
    fromHexString
    max
    min
    removePrefix
    toHexString
    ;

  jsonFormat = pkgs.formats.json { };

  hexPairToInt = pair: builtins.fromJSON "${toString (fromHexString pair)}";

  hexToRgb =
    value:
    let
      hexValue = removePrefix "#" value;
    in
    {
      r = hexPairToInt (builtins.substring 0 2 hexValue);
      g = hexPairToInt (builtins.substring 2 2 hexValue);
      b = hexPairToInt (builtins.substring 4 2 hexValue);
    };

  clampChannel = value: min 255 (max 0 value);

  channelToHex = value: fixedWidthString 2 "0" (toHexString (clampChannel value));

  rgbToHex =
    rgb: "#${channelToHex rgb.r}${channelToHex rgb.g}${channelToHex rgb.b}";

  mix =
    weight: left: right:
    let
      a = hexToRgb left;
      b = hexToRgb right;
      blend = x: y: builtins.floor (((1.0 - weight) * x) + (weight * y));
    in
    rgbToHex {
      r = blend a.r b.r;
      g = blend a.g b.g;
      b = blend a.b b.b;
    };

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

        selected = mix 0.14 surfaceAlt blue;
        userBg = mix 0.04 surface text;
        customBg = mix 0.10 surface purple;
        pendingBg = mix 0.10 surface cyan;
        successBg = mix 0.12 surface green;
        errorBg = mix 0.12 surface red;
        exportInfoBg = mix 0.12 surface yellow;

        theme = {
          "$schema" =
            "https://raw.githubusercontent.com/earendil-works/pi/main/packages/coding-agent/src/modes/interactive/theme/theme-schema.json";
          name = "stylix";

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
