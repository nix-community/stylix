{
  mkTarget,
  lib,
  config,
  options,
  ...
}:
mkTarget {
  options = {
    profileNames = lib.mkOption {
      description = "The Thunderbird profile names to apply styling on.";
      type = lib.types.listOf lib.types.str;

      default = [ ];
      example = [ "default" ];
    };
  };

  config = lib.optionals (options.programs ? thunderbird) [
    ({ cfg }: {
      warnings =
        lib.optional (config.programs.thunderbird.enable && cfg.profileNames == [ ])
          ''stylix: thunderbird: `config.stylix.targets.thunderbird.profileNames` is not set. Declare profile names with 'config.stylix.targets.thunderbird.profileNames = [ "<PROFILE_NAME>" ];'.'';
    })
    ({ cfg, fonts }: {
      programs.thunderbird.profiles = lib.genAttrs cfg.profileNames (_: {
        settings = {
          "font.name.monospace.x-western" = fonts.monospace.name;
          "font.name.sans-serif.x-western" = fonts.sansSerif.name;
          "font.name.serif.x-western" = fonts.serif.name;

          # 4/3 factor used for pt to px;
          # adding 0.5 before flooring for rounding as Thunderbird requires an int
          "font.size.monospace.x-western" = builtins.floor (
            (fonts.sizes.terminal * 4.0 / 3.0) + 0.5
          );
          "font.size.variable.x-western" = builtins.floor (
            (fonts.sizes.applications * 4.0 / 3.0) + 0.5
          );
        };
      });
    })
    (
      { cfg, colors }:
      let
        # Base16 maps `base00` to the default background and `base05` to the
        # default foreground, so comparing their brightness tells us whether
        # the palette should be presented as dark or light. (The generated
        # palette does not record its variant, and `stylix.polarity` is often
        # left at `either`, which is not a decision this module can make.)
        luma =
          color:
          let
            channel = index: lib.fromHexString (builtins.substring index 2 color);
          in
          channel 0 * 2126 + channel 2 * 7152 + channel 4 * 722;
        colorScheme =
          if luma colors.base00 < luma colors.base05 then "dark" else "light";
      in
      {
        programs.thunderbird.profiles = lib.genAttrs cfg.profileNames (_: {
          settings = {
            # The userChrome.css and userContent.css files are local to the
            # profile, so Thunderbird's custom stylesheet support must be on.
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

            # This makes Thunderbird's `light-dark()` tokens and the content
            # pages' `prefers-color-scheme` resolve to the same scheme as the
            # palette.
            "ui.systemUsesDarkTheme" = if colorScheme == "dark" then 1 else 0;
          };

          userChrome = import ./userChrome.nix { inherit colors colorScheme; };

          userContent = import ./userContent.nix { inherit colors colorScheme; };
        });
      }
    )
  ];
}
