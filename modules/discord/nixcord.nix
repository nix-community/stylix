mkTarget:
{
  lib,
  config,
  pkgs,
  options,
  ...
}:
mkTarget {
  name = "nixcord";
  humanName = "Nixcord";

  extraOptions = {
    themeBody = lib.mkOption {
      type = lib.types.lines;
      default = "";
      internal = true;
    };
    extraCss = lib.mkOption {
      description = "Extra CSS to added to Nixcord's theme";
      type = lib.types.lines;
      default = "";
    };
  };

  configElements = (import ./common/theme-elements.nix "nixcord") ++ [
    (
      { cfg }:
      let
        inherit (config.programs) nixcord;
      in
      lib.mkIf
        (cfg.themeBody != (import ./common/theme-header.nix) || cfg.extraCss != "")
        (
          lib.optionalAttrs (builtins.hasAttr "nixcord" options.programs) (
            lib.mkMerge [
              (lib.mkIf nixcord.discord.enable (
                lib.mkMerge [
                  (lib.mkIf (!pkgs.stdenv.hostPlatform.isDarwin || config.xdg.enable) {
                    xdg.configFile."Vencord/themes/stylix.theme.css".text =
                      cfg.themeBody + cfg.extraCss;
                  })

                  (lib.mkIf (pkgs.stdenv.hostPlatform.isDarwin && !config.xdg.enable) {
                    home.file."Library/Application Support/Vencord/themes/stylix.theme.css".text =
                      cfg.themeBody + cfg.extraCss;
                  })
                ]
              ))
              (lib.mkIf nixcord.vesktop.enable (
                lib.mkMerge [
                  (lib.mkIf (!pkgs.stdenv.hostPlatform.isDarwin || config.xdg.enable) {
                    xdg.configFile."vesktop/themes/stylix.theme.css".text =
                      cfg.themeBody + cfg.extraCss;
                  })

                  (lib.mkIf (pkgs.stdenv.hostPlatform.isDarwin && !config.xdg.enable) {
                    home.file."Library/Application Support/vesktop/themes/stylix.theme.css".text =
                      cfg.themeBody + cfg.extraCss;
                  })
                ]
              ))
              {
                programs.nixcord.config.enabledThemes = [ "stylix.theme.css" ];
              }
            ]
          )
        )
    )
  ];
}
