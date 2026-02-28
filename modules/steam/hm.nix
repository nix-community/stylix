{ pkgs, mkTarget, ... }:

mkTarget {
  name = "steam";
  humanName = "Steam";

  config =
    { colors }:
    {
      dconf.settings."io/github/Foldex/AdwSteamGtk".prefs-install-custom-css = true;
      home.packages = [ pkgs.adwsteamgtk ];

      xdg.configFile."AdwSteamGtk/custom.css".source = colors {
        template = ./custom.css.mustache;
        extension = ".css";
      };
    };
}
