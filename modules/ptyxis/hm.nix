{
  mkTarget,
  lib,
  pkgs,
  config,
  ...
}:
mkTarget {
  options.profileUUIDs = lib.mkOption {
    description = "Ptyxis UUIDs to apply styling on.";
    type = lib.types.listOf lib.types.str;
    default = [ ];
    example = [
      "91e845fc983d56328bcae7a46a4519c6"
      "93e38c6d643164750bcfa0ad6a4d270a"
    ];
  };

  config = [
    (
      { cfg }:
      {
        warnings =
          lib.optional (config.programs.ptyxis.enable && cfg.profileUUIDs == [ ])
            ''stylix: ptyxis: `config.stylix.targets.ptyxis.profileUUIDs` is not set. Declare profile UUIDs with `config.stylix.targets.ptyxis.profileUUIDs = [ "<UUID>" ];`.'';

        dconf.settings = lib.mkIf (cfg.profileUUIDs != [ ]) {
          "org/gnome/Ptyxis".default-profile-uuid = lib.head cfg.profileUUIDs;
        };
      }
    )
    (
      { polarity }:
      let
        colorTheme = if polarity == "either" then "system" else polarity;
      in
      {
        dconf.settings."org/gnome/Ptyxis".interface-style = colorTheme;
      }
    )
    (
      { fonts }:
      {
        dconf.settings."org/gnome/Ptyxis" = {
          use-system-font = false;
          font-name = "${fonts.monospace.name} ${toString fonts.sizes.terminal}";
        };
      }
    )
    (
      { opacity, cfg }:
      {
        dconf.settings =
          lib.genAttrs (map (uuid: "org/gnome/Ptyxis/Profiles/${uuid}") cfg.profileUUIDs)
            (_: {
              opacity = lib.hm.gvariant.mkDouble opacity.terminal;
            });
      }
    )
    (
      { colors, cfg }:
      let
        palette = "stylix";
      in
      {
        dconf.settings =
          lib.genAttrs (map (uuid: "org/gnome/Ptyxis/Profiles/${uuid}") cfg.profileUUIDs)
            (_: {
              inherit palette;
            });

        xdg.dataFile."org.gnome.Ptyxis/palettes/stylix.palette".text = ''
          [Palette]
          Name=${palette}

          [Light]
          Foreground=#${colors.base05-hex}
          Background=#${colors.base00-hex}
          TitlebarForeground=#${colors.base05-hex}
          TitlebarBackground=#${colors.base00-hex}
          Cursor=#${colors.base05-hex}
          Color0=#${colors.base00-hex}
          Color1=#${colors.base08-hex}
          Color2=#${colors.base0B-hex}
          Color3=#${colors.base0A-hex}
          Color4=#${colors.base0D-hex}
          Color5=#${colors.base0E-hex}
          Color6=#${colors.base0C-hex}
          Color7=#${colors.base05-hex}
          Color8=#${colors.base03-hex}
          Color9=#${colors.base08-hex}
          Color10=#${colors.base0B-hex}
          Color11=#${colors.base0A-hex}
          Color12=#${colors.base0D-hex}
          Color13=#${colors.base0E-hex}
          Color14=#${colors.base0C-hex}
          Color15=#${colors.base07-hex}

          [Dark]
          Foreground=#${colors.base05-hex}
          Background=#${colors.base00-hex}
          TitlebarForeground=#${colors.base05-hex}
          TitlebarBackground=#${colors.base00-hex}
          Cursor=#${colors.base05-hex}
          Color0=#${colors.base00-hex}
          Color1=#${colors.base08-hex}
          Color2=#${colors.base0B-hex}
          Color3=#${colors.base0A-hex}
          Color4=#${colors.base0D-hex}
          Color5=#${colors.base0E-hex}
          Color6=#${colors.base0C-hex}
          Color7=#${colors.base05-hex}
          Color8=#${colors.base03-hex}
          Color9=#${colors.base08-hex}
          Color10=#${colors.base0B-hex}
          Color11=#${colors.base0A-hex}
          Color12=#${colors.base0D-hex}
          Color13=#${colors.base0E-hex}
          Color14=#${colors.base0C-hex}
          Color15=#${colors.base07-hex}
        '';
      }
    )
  ];
}
