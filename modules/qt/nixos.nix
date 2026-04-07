{
  mkTarget,
  lib,
  config,
  ...
}:
mkTarget {
  options = {
    platform = lib.mkOption {
      description = ''
        Selects the platform theme to use for Qt applications.

        Defaults to the standard platform used in the configured DE.
      '';
      type = lib.types.str;
      default = "qtct";
    };

    _recommendedGnome = lib.mkOption {
      internal = true;
      type = lib.types.singleLineStr;
      default = "adwaita";
    };
  };

  config = [
    (
      { cfg }:
      let
        recommendedStyle = {
          gnome = cfg._recommendedGnome;
          kde = "breeze";
          qtct = "kvantum";
        };
        inherit (config.services.xserver.desktopManager) lxqt;
        inherit (config.services.desktopManager) gnome plasma6;
      in
      {
        stylix.targets.qt.platform =
          if gnome.enable && !(plasma6.enable || lxqt.enable) then
            "gnome"
          else if plasma6.enable && !(gnome.enable || lxqt.enable) then
            "kde"
          else if lxqt.enable && !(gnome.enable || plasma6.enable) then
            "lxqt"
          else
            "qtct";
        qt = {
          enable = true;
          style = recommendedStyle."${config.qt.platformTheme}" or null;
          platformTheme = if cfg.platform == "qtct" then "qt5ct" else cfg.platform;
        };
      }
    )
    (
      { polarity }:
      {
        stylix.targets.qt._recommendedGnome =
          if polarity == "dark" then "adwaita-dark" else "adwaita";
      }
    )
  ];
}
