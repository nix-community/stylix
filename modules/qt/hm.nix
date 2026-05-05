{
  pkgs,
  config,
  lib,
  nixosConfig ? null,
  ...
}:
{
  options.stylix.targets.qt = {
    # TODO: Replace `nixosConfig != null` with
    # `pkgs.stdenv.hostPlatform.isLinux` once [1] ("bug: setting qt.style.name
    # = kvantum makes host systemd unusable") is resolved.
    #
    # [1]: https://github.com/nix-community/home-manager/issues/6565
    enable = config.lib.stylix.mkEnableTargetWith {
      name = "QT";
      autoEnable = nixosConfig != null;
      autoEnableExpr = "nixosConfig != null";
    };

    platform = lib.mkOption {
      description = ''
        Selects the platform theme to use for Qt applications.

        Defaults to the standard platform theme used in the configured DE in NixOS when
        `stylix.homeManagerIntegration.followSystem = true`.
      '';
      type = lib.types.str;
      default = "qtct";
    };

    standardDialogs = lib.mkOption {
      description = ''
        Selects the standard dialogs theme to be used by Qt.

        Using `xdgdesktopportal` integrates with the native desktop portal.
      '';

      # The enum variants are derived from the qt6ct platform theme integration
      # [1].
      #
      # [1]: https://www.opencode.net/trialuser/qt6ct/-/blob/00823e41aa60e8fe266d5aee328e82ad1ad94348/src/qt6ct/appearancepage.cpp#L83-L92
      type = lib.types.enum [
        "default"
        "gtk2"
        "gtk3"
        "kde"
        "xdgdesktopportal"
      ];

      default = "default";
    };
  };

  config = lib.mkIf (config.stylix.enable && config.stylix.targets.qt.enable) (
    let
      icons =
        if (config.stylix.polarity == "dark") then
          config.stylix.icons.dark
        else
          config.stylix.icons.light;

      recommendedStyles = {
        gnome = if config.stylix.polarity == "dark" then "adwaita-dark" else "adwaita";
        kde = "breeze";
        qtct = "kvantum";
      };

      recommendedStyle = recommendedStyles."${config.qt.platformTheme.name}" or null;

      kvantumPackage =
        let
          kvconfig = config.lib.stylix.colors {
            template = ./kvconfig.mustache;
            extension = ".kvconfig";
          };
          svg = config.lib.stylix.colors {
            template = ./kvantum.svg.mustache;
            extension = ".svg";
          };
        in
        pkgs.runCommandLocal "base16-kvantum" { } ''
          directory="$out/share/Kvantum/Base16Kvantum"
          mkdir --parents "$directory"
          cp ${kvconfig} "$directory/Base16Kvantum.kvconfig"
          cp ${svg} "$directory/Base16Kvantum.svg"
        '';

      palette = config.lib.stylix.colors.withHashtag;

      # Base16 inverts base00..base07 luminance between dark and light
      # themes, so the Light/Midlight/Dark/Mid/Shadow shade ramp around
      # Button (base02) has to flip on light schemes or Fusion bevels
      # render upside-down. Users on the default `either` polarity get
      # the dark ramp, since most generator outputs end up dark.
      isDark = config.stylix.polarity != "light";
      shadeDark = if isDark then palette.base00 else palette.base04;
      shadeMid = if isDark then palette.base01 else palette.base03;
      shadeMidlight = if isDark then palette.base03 else palette.base01;
      shadeLight = if isDark then palette.base04 else palette.base00;

      # QPalette::ColorRole order 0..20. qt6ct's parser iterates the
      # enum directly. Accent (21, Qt 6.6+) is auto-filled from
      # Highlight by qt6ct when the row has 21 entries, so omitting it
      # is forward-compatible. Roles overlapping kvconfig.mustache use
      # the same Base16 slot to keep mixed Kvantum + QtQuick UIs
      # visually consistent.
      activePaletteRoles = [
        palette.base05 # 0  WindowText      (kvconfig: window.text.color)
        palette.base02 # 1  Button          (kvconfig: button.color)
        shadeLight # 2  Light
        shadeMidlight # 3  Midlight
        shadeDark # 4  Dark
        shadeMid # 5  Mid
        palette.base05 # 6  Text            (kvconfig: text.color)
        palette.base07 # 7  BrightText      (Qt high-contrast Text fallback)
        palette.base05 # 8  ButtonText      (kvconfig: button.text.color)
        palette.base00 # 9  Base            (kvconfig: base.color)
        palette.base01 # 10 Window          (kvconfig: window.color)
        shadeDark # 11 Shadow
        palette.base0E # 12 Highlight       (kvconfig: highlight.color)
        # HighlightedText diverges from kvconfig.mustache (base00):
        # on schemes where Highlight (base0E) and Window (base01)
        # collapse toward similar luminance, base00 makes selected
        # text unreadable. base05 keeps high contrast against any
        # Highlight choice.
        palette.base05 # 13 HighlightedText
        palette.base0D # 14 Link            (kvconfig: link.color)
        palette.base0E # 15 LinkVisited     (kvconfig: link.visited.color)
        palette.base01 # 16 AlternateBase   (kvconfig: alt.base.color)
        palette.base00 # 17 NoRole
        palette.base00 # 18 ToolTipBase    (kvconfig: tooltip.base.color)
        palette.base05 # 19 ToolTipText     (kvconfig: tooltip.text.color)
        palette.base04 # 20 PlaceholderText
      ];

      # Inactive: only Highlight differs (base03), matching kvconfig
      # `inactive.highlight.color`.
      inactivePaletteRoles = lib.imap0 (
        i: v: if i == 12 then palette.base03 else v
      ) activePaletteRoles;

      # Disabled: foregrounds and accent collapse to muted base02..base04;
      # backgrounds and shade ramp match active to preserve silhouette.
      # Without a distinct disabled row, Qt no longer auto-greys widgets
      # under a custom palette, so disabled controls would render
      # identical to enabled ones.
      disabledPaletteRoles = [
        palette.base04 # 0  WindowText
        palette.base02 # 1  Button
        shadeLight # 2  Light
        shadeMidlight # 3  Midlight
        shadeDark # 4  Dark
        shadeMid # 5  Mid
        palette.base04 # 6  Text
        palette.base04 # 7  BrightText
        palette.base04 # 8  ButtonText
        palette.base00 # 9  Base
        palette.base01 # 10 Window
        shadeDark # 11 Shadow
        palette.base02 # 12 Highlight
        palette.base04 # 13 HighlightedText
        palette.base04 # 14 Link
        palette.base04 # 15 LinkVisited
        palette.base01 # 16 AlternateBase
        palette.base00 # 17 NoRole
        palette.base00 # 18 ToolTipBase
        palette.base04 # 19 ToolTipText
        palette.base03 # 20 PlaceholderText
      ];

      toArgb = c: "#ff${lib.removePrefix "#" c}";
      formatRow = colours: lib.concatStringsSep ", " (map toArgb colours);

      schemeText = ''
        [ColorScheme]
        active_colors=${formatRow activePaletteRoles}
        inactive_colors=${formatRow inactivePaletteRoles}
        disabled_colors=${formatRow disabledPaletteRoles}
      '';
    in
    {
      warnings =
        (lib.optional (config.stylix.targets.qt.platform != "qtct")
          "stylix: qt: `config.stylix.targets.qt.platform` other than 'qtct' are currently unsupported: ${config.stylix.targets.qt.platform}. Support may be added in the future."
        )
        ++ (lib.optional (config.qt.style.name != recommendedStyle)
          "stylix: qt: Changing `config.qt.style` is unsupported and may result in breakage! Use with caution!"
        );

      qt =
        let
          qtctSettings = qtct: {
            Appearance = {
              custom_palette = true;
              standard_dialogs = config.stylix.targets.qt.standardDialogs;
              style = lib.mkIf (config.qt.style ? name) config.qt.style.name;
              icon_theme = lib.mkIf (icons != null) icons;
              color_scheme_path = "${config.xdg.configHome}/${qtct}/colors/stylix.conf";
            };

            Fonts = {
              fixed = ''"${config.stylix.fonts.monospace.name},${toString config.stylix.fonts.sizes.applications}"'';
              general = ''"${config.stylix.fonts.sansSerif.name},${toString config.stylix.fonts.sizes.applications}"'';
            };
          };
        in
        {
          enable = true;
          style.name = recommendedStyle;
          platformTheme.name = config.stylix.targets.qt.platform;

          qt5ctSettings = lib.mkIf (config.qt.platformTheme.name == "qtct") (
            qtctSettings "qt5ct"
          );
          qt6ctSettings = lib.mkIf (config.qt.platformTheme.name == "qtct") (
            qtctSettings "qt6ct"
          );

          kvantum = lib.mkIf (config.qt.style.name == "kvantum") {
            enable = true;
            settings.General.theme = "Base16Kvantum";
            themes = [ kvantumPackage ];
          };
        };

      xdg.configFile = lib.mkIf (config.qt.platformTheme.name == "qtct") {
        "qt5ct/colors/stylix.conf".text = schemeText;
        "qt6ct/colors/stylix.conf".text = schemeText;
      };
    }
  );
}
