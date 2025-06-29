mkTarget:
{
  lib,
  options,
  config,
  ...
}:
mkTarget {
  name = "nixvim";
  humanName = "NixVim";
  extraOptions = {
    plugin = lib.mkOption {
      type = lib.types.enum [
        "base16-nvim"
        "mini.base16"
      ];
      default = "mini.base16";
      description = "Plugin used for the colorscheme";
    };
    transparentBackground = {
      main = lib.mkEnableOption "background transparency for the main NeoVim window";
      signColumn = lib.mkEnableOption "background transparency for the NeoVim sign column";
      numberLine = lib.mkEnableOption "background transparency for the NeoVim number/relativenumber column";
    };

    module = lib.mkOption {
      type = lib.types.deferredModule;
      internal = true;
    };
    pluginConfigs = lib.mkOption {
      type = lib.types.anything;
      default = { };
      internal = true;
    };
    exportedModule = lib.mkOption {
      type = lib.types.deferredModule;
      description = ''
        Theming configuration which can be merged with your own. See
        [Standalone Mode](#standalone-mode) documentation.
      '';
      readOnly = true;
    };
  };

  configElements = [
    (
      { colors }:
      {
        stylix.targets.nixvim.pluginConfigs = {
          "base16-nvim".colorschemes.base16.colorscheme = {
            inherit (colors.withHashtag)
              base00
              base01
              base02
              base03
              base04
              base05
              base06
              base07
              base08
              base09
              base0A
              base0B
              base0C
              base0D
              base0E
              base0F
              ;
          };
          "mini.base16".plugins.mini.modules.base16.palette = {
            inherit (colors.withHashtag)
              base00
              base01
              base02
              base03
              base04
              base05
              base06
              base07
              base08
              base09
              base0A
              base0B
              base0C
              base0D
              base0E
              base0F
              ;
          };
        };
      }
    )
    (
      { fonts }:
      {
        stylix.targets.nixvim.module.opts.guifont =
          "${fonts.monospace.name}:h${toString fonts.sizes.terminal}";
      }
    )
    (
      { opacity }:
      {
        stylix.targets.nixvim.module = lib.modules.importApply ./neovide-common.nix opacity;
      }
    )
    (
      { cfg }:
      {
        stylix.targets.nixvim = {
          pluginConfigs =
            let
              # Transparent is used a few times below
              transparent = {
                bg = "none";
                ctermbg = "none";
              };
              highlightOverride = {
                Normal = lib.mkIf cfg.transparentBackground.main transparent;
                NonText = lib.mkIf cfg.transparentBackground.main transparent;
                SignColumn = lib.mkIf cfg.transparentBackground.signColumn transparent;
                LineNr = lib.mkIf cfg.transparentBackground.numberLine transparent;
                LineNrAbove = lib.mkIf cfg.transparentBackground.numberLine transparent;
                LineNrBelow = lib.mkIf cfg.transparentBackground.numberLine transparent;
              };
            in
            {
              "base16-nvim" = {
                colorschemes.enable = true;
                inherit highlightOverride;
              };
              "mini.base16" = {
                plugins.mini.enable = true;
                inherit highlightOverride;
              };
            };
          module = cfg.pluginConfigs.${cfg.plugin};
          exportedModule = cfg.module;
        };
        programs = lib.optionalAttrs (options.programs ? nixvim) {
          nixvim = cfg.module;
        };
      }
    )
  ];

  imports = [
    (lib.mkRenamedOptionModuleWith {
      from = [
        "stylix"
        "targets"
        "nixvim"
        "transparent_bg"
        "main"
      ];
      sinceRelease = 2411;
      to = [
        "stylix"
        "targets"
        "nixvim"
        "transparentBackground"
        "main"
      ];
    })

    (lib.mkRenamedOptionModuleWith {
      from = [
        "stylix"
        "targets"
        "nixvim"
        "transparent_bg"
        "sign_column"
      ];
      sinceRelease = 2411;

      to = [
        "stylix"
        "targets"
        "nixvim"
        "transparentBackground"
        "signColumn"
      ];
    })

    (
      { config, ... }:
      {
        lib.stylix.nixvim.config = lib.warn "stylix: `config.lib.stylix.nixvim.config` has been renamed to `config.stylix.targets.nixvim.exportedModule` and will be removed after 26.11" config.stylix.targets.nixvim.exportedModule;
      }
    )
  ];
}
