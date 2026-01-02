{ mkTarget, stylixLib }:
{ lib, ... }:
mkTarget {
  submodule = true;
  inherit stylixLib;

  options.enableCss = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "enables userChrome and userContent css styles for the browser";
  };

  config = [
    (
      { fonts }:
      {
        settings = {
          "font.name.monospace.x-western" = fonts.monospace.name;
          "font.name.sans-serif.x-western" = fonts.sansSerif.name;
          "font.name.serif.x-western" = fonts.serif.name;
        };
      }
    )
    (
      { cfg, colors }:
      lib.mkIf cfg.enableCss {
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };

        userChrome = import ./userChrome.nix { inherit colors; };

        userContent = import ./userContent.nix { inherit colors; };
      }
    )
  ];
}
