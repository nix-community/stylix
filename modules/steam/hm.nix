{
  lib,
  pkgs,
  mkTarget,
  ...
}:

let
  adwsteamgtk = pkgs.adwsteamgtk.overridePythonAttrs {
    # See https://github.com/Foldex/AdwSteamGtk/pull/95
    src = pkgs.fetchFromGitHub {
      owner = "Foldex";
      repo = "AdwSteamGtk";
      rev = "a003d50a6adab743356b5f2538db83bb78ea6e36";
      hash = "sha256-zBlNKtV8VpElxeJfjXJudOTMpjmfZdzSEOCuu4FgJ0s=";
    };
  };
in
mkTarget {
  name = "steam";
  humanName = "Steam";

  extraOptions = {
    adwaitaTheme.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = ''
        Whether to enable the Adwaita theme for Steam.

        > [!IMPORTANT]
        > This option will install and configure the AdwSteamGtk application.
        > The theme can be applied by running this application.
      '';
    };
  };

  configElements =
    { cfg, colors }:
    lib.mkIf cfg.adwaitaTheme.enable {
      home.packages = [ adwsteamgtk ];

      dconf.settings."io/github/Foldex/AdwSteamGtk".prefs-install-custom-css = true;

      xdg.configFile."AdwSteamGtk/custom.css".source = colors {
        template = ./custom.css.mustache;
        extension = ".css";
      };
    };
}
