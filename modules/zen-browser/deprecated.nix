{
  lib,
  config,
  options,
  ...
}:
let
  cfg = config.stylix.targets.zen-browser;
in
{
  options.stylix.targets.zen-browser = {
    enable = config.lib.stylix.mkEnableTarget "Zen Browser" true;

    profileNames = lib.mkOption {
      description = "The Zen Browser profile names to apply styling on.";
      type = lib.types.listOf lib.types.str;
      default = [ ];
      example = [ "default" ];
    };

    enableCss = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "enables userChrome and userContent css styles for the browser";
    };
  };

  config = lib.optionalAttrs (options.programs ? zen-browser) (
    lib.mkIf cfg.enable {
      warnings = [
        (lib.mkIf (!cfg.enable)
          "stylix: zen-browser: `stylix.targets.zen-browser.enable` is deprecated, use `programs.zen-browser.profiles.<name>.stylix.enable` instead"
        )
        (lib.mkIf (cfg.profileNames != [ ])
          "stylix: zen-browser: `stylix.targets.zen-browser.profileNames` is deprecated, use `programs.zen-browser.profiles.<name>.stylix.enable` instead"
        )
        (lib.mkIf (!cfg.enableCss)
          "stylix: zen-browser: `stylix.targets.zen-browser.enableCss` is deprecated, use `programs.zen-browser.profiles.<name>.stylix.enableCss` instead"
        )
      ];

      programs.zen-browser.profiles = lib.genAttrs cfg.profileNames (_: {
        stylix = { inherit (cfg) enable enableCss; };
      });
    }
  );
}
