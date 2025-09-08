{
  pkgs,
  mkTarget,
  ...
}:

mkTarget {
  name = "steam";
  humanName = "Steam";

  configElements =
    { colors }:
    {
      home.packages = [ pkgs.adwsteamgtk ];

      dconf.settings."io/github/Foldex/AdwSteamGtk".prefs-install-custom-css = true;

      xdg.configFile."AdwSteamGtk/custom.css".source = colors {
        template = ./custom.css.mustache;
        extension = ".css";
      };
    };
}
