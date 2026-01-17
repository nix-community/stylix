{ mkTarget, lib, ... }:
mkTarget {
  options.themeBody = lib.mkOption {
    type = lib.types.lines;
    default = "";
    internal = true;
  };

  config = [
    ./color-theme.nix
    ./font-theme.nix
    (
      { cfg }:
      {
        xdg.configFile =
          let
            indent =
              string: "  " + lib.concatStringsSep "\n  " (lib.splitString "\n" string);
          in
          lib.mkIf (cfg.themeBody != "") (
            builtins.listToAttrs (
              map
                (
                  version:
                  lib.nameValuePair
                    "blender/${version}/scripts/presets/interface_theme/Stylix.xml"
                    {
                      text = lib.concatLines [
                        "<bpy>"
                        (indent cfg.themeBody)
                        "</bpy>"
                      ];
                    }
                )
                [
                  "3.0"
                  "3.1"
                  "3.2"
                  "3.3"
                  "3.4"
                  "3.5"
                  "3.6"
                  "4.0"
                  "4.1"
                  "4.2"
                  "4.3"
                  "4.4"
                  "4.5"
                ]
            )
          );
      }
    )
  ];
}
