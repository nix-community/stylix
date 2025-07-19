{ mkTarget, ... }:
mkTarget {
  name = "gedit";
  humanName = "GEdit";

  config =
    { colors }:
    {
      xdg.dataFile = {
        "gedit/styles/stylix.xml".source = colors {
          template = ../gtksourceview/template.xml.mustache;
          extension = ".xml";
        };
      };
    };
}
