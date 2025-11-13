{ lib, ... }:
{
  imports = [
    (lib.mkRenamedOptionModuleWith {
      from = [
        "stylix"
        "iconTheme"
        "dark"
      ];
      sinceRelease = 2511;
      to = [
        "stylix"
        "icons"
        "dark"
      ];
    })
    (lib.mkRenamedOptionModuleWith {
      from = [
        "stylix"
        "iconTheme"
        "enable"
      ];
      sinceRelease = 2511;
      to = [
        "stylix"
        "icons"
        "enable"
      ];
    })
    (lib.mkRenamedOptionModuleWith {
      from = [
        "stylix"
        "iconTheme"
        "light"
      ];
      sinceRelease = 2511;
      to = [
        "stylix"
        "icons"
        "light"
      ];
    })
    (lib.mkRenamedOptionModuleWith {
      from = [
        "stylix"
        "iconTheme"
        "package"
      ];
      sinceRelease = 2511;
      to = [
        "stylix"
        "icons"
        "package"
      ];
    })
  ];

  options.stylix.icons = {
    enable = lib.mkOption {
      description = "enable/disable icon theming.";
      type = lib.types.bool;
      default = false;
    };
    package = lib.mkOption {
      description = "Package providing the icon theme.";
      type = lib.types.nullOr lib.types.package;
      default = null;
    };
    light = lib.mkOption {
      description = "Light icon theme name.";
      type = lib.types.nullOr lib.types.str;
      default = null;
    };
    dark = lib.mkOption {
      description = "Dark icon theme name.";
      type = lib.types.nullOr lib.types.str;
      default = null;
    };
  };
}
