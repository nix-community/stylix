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
    in
    {
      warnings =
        (lib.optional (config.stylix.targets.qt.platform != "qtct")
          "stylix: qt: `config.stylix.targets.qt.platform` other than 'qtct' are currently unsupported: ${config.stylix.targets.qt.platform}. Support may be added in the future."
        )
        ++ (lib.optional (config.qt.style.name != recommendedStyle)
          "stylix: qt: Changing `config.qt.style` is unsupported and may result in breakage! Use with caution!"
        );

      home.packages = lib.optional (config.qt.style.name == "kvantum") kvantumPackage;

      qt =
        let
          qtctSettings = {
            Appearance = {
              custom_palette = true;
              standard_dialogs = config.stylix.targets.qt.standardDialogs;
              style = lib.mkIf (config.qt.style ? name) config.qt.style.name;
              icon_theme = lib.mkIf (icons != null) icons;
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

          qt5ctSettings = lib.mkIf (config.qt.platformTheme.name == "qtct") qtctSettings;
          qt6ctSettings = lib.mkIf (config.qt.platformTheme.name == "qtct") qtctSettings;
        };

      xdg.configFile = lib.mkIf (config.qt.style.name == "kvantum") {
        "Kvantum/kvantum.kvconfig".source =
          (pkgs.formats.ini { }).generate "kvantum.kvconfig"
            { General.theme = "Base16Kvantum"; };
        "Kvantum/Base16Kvantum".source =
          "${kvantumPackage}/share/Kvantum/Base16Kvantum";
      };
    }
  );
}
