{
  mkTarget,
  lib,
  config,
  ...
}:
mkTarget {
  options.profileUUIDs = lib.mkOption {
    description = ''
      Ptyxis profile UUIDs to apply styling on.

      Ptyxis stores per profile settings under
      `org/gnome/Ptyxis/Profiles/<UUID>`, as documented in the
      [`org.gnome.Ptyxis` GSettings schema](https://gitlab.gnome.org/chergert/ptyxis/-/blob/main/src/org.gnome.Ptyxis.gschema.xml.in).

      Profiles created through the Ptyxis user interface receive a randomly
      generated UUID, which can be listed with:

      ```bash
      dconf read /org/gnome/Ptyxis/profile-uuids
      ```

      Since Ptyxis does not validate UUIDs, and only uses them as GSettings
      path segments, profiles can alternatively be declared with arbitrary,
      host independent UUIDs:

      ```nix
      {
        dconf.settings."org/gnome/Ptyxis".profile-uuids = [ "<UUID>" ];
        stylix.targets.ptyxis.profileUUIDs = [ "<UUID>" ];
      }
      ```

      If unset, no profile is styled and `default-profile-uuid` is left
      untouched. Otherwise, the first declared UUID becomes the default
      profile.
    '';

    type = lib.types.listOf lib.types.str;
    default = [ ];

    example = [
      "91e845fc983d56328bcae7a46a4519c6"
      "93e38c6d643164750bcfa0ad6a4d270a"
    ];
  };

  config = [
    ({ cfg }: {
      warnings =
        lib.optional (config.programs.ptyxis.enable && cfg.profileUUIDs == [ ])
          ''stylix: ptyxis: `config.stylix.targets.ptyxis.profileUUIDs` is not set. Declare profile UUIDs with `config.stylix.targets.ptyxis.profileUUIDs = [ "<UUID>" ];`.'';

      dconf.settings = lib.mkIf (cfg.profileUUIDs != [ ]) {
        "org/gnome/Ptyxis".default-profile-uuid = lib.head cfg.profileUUIDs;
      };
    })
    (
      { polarity }:
      let
        colorTheme = if polarity == "either" then "system" else polarity;
      in
      {
        dconf.settings."org/gnome/Ptyxis".interface-style = colorTheme;
      }
    )
    ({ fonts }: {
      # The `font-name` key is only honored when `use-system-font` is disabled:
      # https://gitlab.gnome.org/chergert/ptyxis/-/blob/main/src/org.gnome.Ptyxis.gschema.xml.in#L144
      dconf.settings."org/gnome/Ptyxis" = {
        use-system-font = false;
        font-name = "${fonts.monospace.name} ${toString fonts.sizes.terminal}";
      };
    })
    ({ opacity, cfg }: {
      dconf.settings =
        lib.genAttrs (map (uuid: "org/gnome/Ptyxis/Profiles/${uuid}") cfg.profileUUIDs)
          (_: {
            opacity = lib.hm.gvariant.mkDouble opacity.terminal;
          });
    })
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

        xdg.dataFile."org.gnome.Ptyxis/palettes/stylix.palette".text =
          with colors.withHashtag; ''
            [Palette]
            Name=${palette}

            [Light]
            Foreground=${base05}
            Background=${base00}
            TitlebarForeground=${base05}
            TitlebarBackground=${base00}
            Cursor=${base05}
            Color0=${base00}
            Color1=${base08}
            Color2=${base0B}
            Color3=${base0A}
            Color4=${base0D}
            Color5=${base0E}
            Color6=${base0C}
            Color7=${base05}
            Color8=${base03}
            Color9=${base08}
            Color10=${base0B}
            Color11=${base0A}
            Color12=${base0D}
            Color13=${base0E}
            Color14=${base0C}
            Color15=${base07}

            [Dark]
            Foreground=${base05}
            Background=${base00}
            TitlebarForeground=${base05}
            TitlebarBackground=${base00}
            Cursor=${base05}
            Color0=${base00}
            Color1=${base08}
            Color2=${base0B}
            Color3=${base0A}
            Color4=${base0D}
            Color5=${base0E}
            Color6=${base0C}
            Color7=${base05}
            Color8=${base03}
            Color9=${base08}
            Color10=${base0B}
            Color11=${base0A}
            Color12=${base0D}
            Color13=${base0E}
            Color14=${base0C}
            Color15=${base07}
          '';
      }
    )
  ];
}
