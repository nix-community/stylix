{ mkTarget, lib, ... }:
mkTarget {
  name = "i3";
  humanName = "i3";

  extraOptions.exportedBarConfig = lib.mkOption {
    type = lib.types.attrs;
    description = ''
      Theming configuration which can be merged with your own:

      ```nix
      xsession.windowManager.i3.config.bars = [
        (
          {
            # your configuration
          }
          // config.stylix.targets.i3.exportedBarConfig
        )
      ];
      ```
    '';
    readOnly = true;
  };

  imports = [
    (
      { config, ... }:
      {
        lib.stylix.i3.bar = builtins.warn "stylix: `config.lib.stylix.i3.bar` has been renamed to `config.stylix.targets.i3.exportedBarConfig` and will be removed after 26.11." config.stylix.targets.i3.exportedBarConfig;
        stylix.targets.i3.exportedBarConfig = lib.mkIf (
          !config.stylix.targets.i3.enable
        ) (throw "`config.stylix.targets.i3.enable` must be true");
      }
    )
  ];

  configElements = [
    (
      { fonts }:
      {
        xsession.windowManager.i3.config.fonts = {
          names = [ fonts.sansSerif.name ];
          size = fonts.sizes.desktop * 1.0;
        };
      }
    )
    (
      { colors }:
      {
        xsession.windowManager.i3.config.colors =
          with colors.withHashtag;
          let
            text = base05;
            urgent = base08;
            focused = base0D;
            unfocused = base03;
            background = base00;
            indicator = base0B;
          in
          {
            inherit background;
            urgent = {
              inherit background indicator text;
              border = urgent;
              childBorder = urgent;
            };
            focused = {
              inherit background indicator text;
              border = focused;
              childBorder = focused;
            };
            focusedInactive = {
              inherit background indicator text;
              border = unfocused;
              childBorder = unfocused;
            };
            unfocused = {
              inherit background indicator text;
              border = unfocused;
              childBorder = unfocused;
            };
            placeholder = {
              inherit background indicator text;
              border = unfocused;
              childBorder = unfocused;
            };
          };
      }
    )
    (
      { fonts }:
      {
        stylix.targets.i3.exportedBarConfig.fonts = {

          names = [ fonts.sansSerif.name ];
          size = fonts.sizes.desktop * 1.0;
        };
      }
    )
    (
      { colors }:
      {
        stylix.targets.i3.exportedBarConfig.colors =
          with colors.withHashtag;
          let
            text = base05;
            urgent = base08;
            focused = base0D;
            background = base00;
            border = background;
          in
          {
            inherit background;
            statusline = text;
            separator = base03;
            focusedWorkspace = {
              inherit text background;
              border = focused;
            };
            activeWorkspace = {
              inherit border background;
              text = focused;
            };
            inactiveWorkspace = {
              inherit text border background;
            };
            urgentWorkspace = {
              inherit text background;
              border = urgent;
            };
            bindingMode = {
              inherit text border;
              background = urgent;
            };
          };
      }
    )
  ];
}
