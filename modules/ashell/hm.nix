{ mkTarget, ... }:
mkTarget {
  name = "ashell";
  humanName = "Ashell";

  configElements = [
    (
      { colors }:
      {
        programs.ashell.settings.appearance = with colors.withHashtag; {
          background_color = base00;
          primary_color = base0D;
          secondary_color = base01;
          success_color = base0B;
          danger_color = base09;
          text_color = base05;

          workspace_colors = [
            base09
            base0D
          ];
        };
      }
    )
    (
      { opacity }:
      {
        programs.ashell.settings.appearance = {
          inherit opacity;
          menu.opacity = opacity;
        };
      }
    )
  ];
}
