{ mkTarget, ... }:
mkTarget {
  config = [
    (
      { fonts }:
      {
        programs.prismlauncher.settings = {
          ConsoleFont = fonts.monospace.name;
          ConsoleFontSize = fonts.sizes.terminal;
        };
      }
    )
    (
      { colors }:
      {
        programs.prismlauncher = {
          settings.ApplicationTheme = "stylix";

          themes.stylix.theme = with colors.withHashtag; {
            colors = {
              AlternateBase = base01;
              Base = base00;
              BrightText = base08;
              Button = base01;
              ButtonText = base05;
              Highlight = base02;
              HighlightedText = base05;
              Link = base0D;
              Text = base05;
              ToolTipBase = base00;
              ToolTipText = base05;
              Window = base00;
              WindowText = base05;
              fadeAmount = 0.5;
              fadeColor = base02;
            };
            logColors = {
              Debug = base0B;
              DebugHighlight = base03;
              Error = base08;
              ErrorHighlight = base03;
              Fatal = base08;
              FatalHighlight = base00;
              Launcher = base0D;
              LauncherHighlight = base03;
              Message = base05;
              MessageHighlight = base02;
              Warning = base0A;
              WarningHighlight = base03;
            };
            name = "Stylix";
            widgets = "Fusion";
          };
        };
      }
    )
  ];
}
