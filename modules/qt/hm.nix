{
  mkTarget,
  pkgs,
  config,
  lib,
  nixosConfig ? null,
  ...
}:
let
  qtctSettings = attrs: {
    qt5ctSettings = lib.mkIf (config.qt.platformTheme.name == "qtct") attrs;
    qt6ctSettings = lib.mkIf (config.qt.platformTheme.name == "qtct") attrs;
  };
in
mkTarget {
  # TODO: Replace `nixosConfig != null` with
  # `pkgs.stdenv.hostPlatform.isLinux` once [1] ("bug: setting qt.style.name
  # = kvantum makes host systemd unusable") is resolved.
  #
  # [1]: https://github.com/nix-community/home-manager/issues/6565
  autoEnable = nixosConfig != null;
  autoEnableExpr = "nixosConfig != null";

  options = {
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

    _recommendedGnome = lib.mkOption {
      internal = true;
      type = lib.types.singleLineStr;
      default = "adwaita";
    };
  };

  config = [
    (
      { cfg }:
      let
        recommendedStyles = {
          gnome = cfg._recommendedGnome;
          kde = "breeze";
          qtct = "kvantum";
        };

        recommendedStyle = recommendedStyles."${config.qt.platformTheme.name}" or null;
      in
      {
        warnings =
          (lib.optional (cfg.platform != "qtct")
            "stylix: qt: `config.stylix.targets.qt.platform` other than 'qtct' are currently unsupported: ${cfg.platform}. Support may be added in the future."
          )
          ++ (lib.optional (config.qt.style.name != recommendedStyle)
            "stylix: qt: Changing `config.qt.style` is unsupported and may result in breakage! Use with caution!"
          );

        qt = lib.mkMerge [
          {
            enable = true;
            style.name = recommendedStyle;
            platformTheme.name = cfg.platform;
          }
          (qtctSettings {
            Appearance = {
              custom_palette = true;
              standard_dialogs = cfg.standardDialogs;
              style = lib.mkIf (config.qt.style ? name) config.qt.style.name;
            };
          })
        ];
      }
    )
    (
      { polarity }:
      {
        stylix.targets.qt._recommendedGnome =
          if polarity == "dark" then "adwaita-dark" else "adwaita";
      }
    )
    (
      { colors }:
      let
        kvantumPackage =
          let
            kvconfig = colors {
              template = ./kvconfig.mustache;
              extension = ".kvconfig";
            };
            svg = colors {
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
        home.packages = lib.optional (config.qt.style.name == "kvantum") kvantumPackage;

        xdg.configFile = lib.mkIf (config.qt.style.name == "kvantum") {
          "Kvantum/kvantum.kvconfig".source =
            (pkgs.formats.ini { }).generate "kvantum.kvconfig"
              { General.theme = "Base16Kvantum"; };
          "Kvantum/Base16Kvantum".source =
            "${kvantumPackage}/share/Kvantum/Base16Kvantum";
        };
      }
    )
    (
      { icons, polarity }:
      {
        qt = qtctSettings {
          Appearance = {
            icon_theme = if (polarity == "dark") then icons.dark else icons.light;
          };
        };
      }
    )
    (
      { fonts }:
      {
        qt = qtctSettings {
          Fonts = {
            fixed = ''"${fonts.monospace.name},${toString fonts.sizes.applications}"'';
            general = ''"${fonts.sansSerif.name},${toString fonts.sizes.applications}"'';
          };
        };
      }
    )
  ];
}
