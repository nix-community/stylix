{ mkTarget, ... }:
let
  style = {
    template = ./template.xml.mustache;
    extension = ".xml";
  };
in
mkTarget {
  name = "gtksourceview";
  humanName = "GTKSourceView";

  configElements =
    { colors, ... }:
    {
      xdg.dataFile = {
        "gtksourceview-2.0/styles/stylix.xml".source = colors style;
        "gtksourceview-3.0/styles/stylix.xml".source = colors style;
        "gtksourceview-4/styles/stylix.xml".source = colors style;
        "gtksourceview-5/styles/stylix.xml".source = colors style;
      };
    };
}
