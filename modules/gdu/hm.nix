{
  mkTarget,
  ...
}:
mkTarget {
  name = "gdu";
  humanName = "go DiskUsage()";

  configElements =
    { colors }:
    {
      xdg.configFile."gdu/gdu.yaml" = {
        enable = true;
        text = with colors.withHashtag; ''
          style:
            selected-row:
              text-color: "${base05}"
              background-color: "${base00}"
            result-row:
              number-color: "${base06}"
              directory-color: "${base02}"
            footer:
              text-color: "${base05}"
              background-color: "${base00}"
              number-color: "${base06}"
            header:
              text-color: "${base05}"
              background-color: "${base00}"
        '';
      };
    };
}
