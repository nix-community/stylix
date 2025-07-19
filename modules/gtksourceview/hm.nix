{ mkTarget, lib, ... }:
mkTarget {
  config =
    { colors, ... }:
    {
      xdg.dataFile = builtins.listToAttrs (
        map
          (
            version:
            lib.nameValuePair "gtksourceview-${version}/styles/stylix.xml" {
              source = colors {
                template = ./template.xml.mustache;
                extension = ".xml";
              };
            }
          )
          [
            "2.0"
            "3.0"
            "4"
            "5"
          ]
      );
    };
}
