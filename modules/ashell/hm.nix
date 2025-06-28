{
  mkTarget,
  ...
}:
mkTarget {
  name = "ashell";
  humanName = "Ashell";
  configElements =
    { colors }:
    {
      programs.ashell.settings.appearance = with colors.withHashtag; {
        backgroundColor = base00;
        primaryColor = base0D;
        secondaryColor = base01;
        successColor = base0B;
        dangerColor = base09;
        textColor = base05;

        workspaceColors = [
          base09
          base0D
        ];
      };
    };
}
