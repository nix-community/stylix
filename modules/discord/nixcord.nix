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

  options = {
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

  config = (import ./common/theme-elements.nix "nixcord") ++ [
    (
      { cfg }:
      let
        inherit (config.programs) nixcord;

        writePath =
          name:
          lib.mkMerge [
            (lib.mkIf (!pkgs.stdenv.hostPlatform.isDarwin || config.xdg.enable) {
              xdg.configFile."${name}/themes/stylix.theme.css".text =
                cfg.themeBody + cfg.extraCss;
            })
            (lib.mkIf (pkgs.stdenv.hostPlatform.isDarwin && !config.xdg.enable) {
              home.file."Library/Application Support/${name}/themes/stylix.theme.css".text =
                cfg.themeBody + cfg.extraCss;
            })
          ];
      in
      lib.mkIf
        (cfg.themeBody != (import ./common/theme-header.nix) || cfg.extraCss != "")
        (
          lib.optionalAttrs (options.programs ? nixcord) (
            lib.mkMerge [
              (lib.mkIf nixcord.discord.enable (writePath "Vencord"))
              (lib.mkIf nixcord.vesktop.enable (writePath "vesktop"))
              (lib.mkIf (nixcord.discord.equicord.enable && nixcord.discord.enable) (
                writePath "Equicord"
              ))
              (lib.mkIf nixcord.equibop.enable (writePath "equibop"))
              { programs.nixcord.config.enabledThemes = [ "stylix.theme.css" ]; }
            ]
          )
        )
    )
  ];
}
