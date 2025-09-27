{
  mkTarget,
  lib,
  config,
  ...
}:
mkTarget {
  name = "obsidian";

  extraOptions = {
    vaultNames = lib.mkOption {
      description = "The obsidian vault names to apply styling on.";
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };
  };

  humanName = "Obsidian";
  configElements = [
    (
      { cfg }:
      {
        warnings =
          lib.optional (config.programs.obsidian.enable && cfg.vaultNames == [ ])
            ''stylix: obsidian: `config.stylix.targets.obsidian.vaultNames` is not set. Declare vault names with 'config.stylix.targets.obsidian.vaultnames = [ "<VAULT_NAME>" ];'.'';
      }
    )
    (
      { cfg, fonts }:
      {
        programs.obsidian.vaults = lib.genAttrs cfg.vaultNames (_: {
          settings.appearance = {
            "interfaceFontFamily" = fonts.sansSerif.name; # would be nice if people could choose between serif and sansserif
            "monospaceFontFamily" = fonts.monospace.name;
            "baseFontSize" = fonts.sizes.applications;
          };
        });
      }
    )
    (
      {
        cfg,
        colors,
        polarity,
      }:
      {
        programs.obsidian.vaults = lib.genAttrs cfg.vaultNames (_: {
          settings.cssSnippets = with colors.withHashtag; [
            {
              name = "Stylix Config";
              text = "
                  .theme-${polarity} {
                      /* Base Colors */
                      --color-base-00: ${base00};
                      --color-base-05: ${base00};
                      --color-base-10: ${base00};
                      --color-base-20: ${base01};
                      --color-base-25: ${base01};
                      --color-base-30: ${base02};
                      --color-base-35: ${base02};
                      --color-base-40: ${base03};
                      --color-base-50: ${base03};
                      --color-base-60: ${base04};
                      --color-base-70: ${base04};
                      --color-base-100: ${base05};

                      --color-accent: ${base0E};
                      --color-accent-1: ${base0E};
                  }";
            }
          ];
        });
      }
    )
  ];
}
