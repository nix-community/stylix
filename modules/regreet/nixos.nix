{
  mkTarget,
  pkgs,
  config,
  lib,
  ...
}:
mkTarget {
  imports = [
    (lib.mkRenamedOptionModuleWith {
      from = [
        "stylix"
        "targets"
        "regreet"
        "useWallpaper"
      ];
      sinceRelease = 2605;
      to = [
        "stylix"
        "targets"
        "regreet"
        "image"
        "enable"
      ];
    })
  ];

  autoEnable = pkgs.stdenv.hostPlatform.isLinux;
  autoEnableExpr = "pkgs.stdenv.hostPlatform.isLinux";

  options.extraCss = lib.mkOption {
    description = ''
      Extra code added to `services.displayManager.regreet.extraCss` option.
    '';
    type = lib.types.lines;
    default = "";
    example = "window.background { border-radius: 0; }";
  };

  config = [
    {
      warnings =
        let
          cfg = config.services.displayManager.regreet;
        in
        lib.optional
          (
            cfg.enable
            &&
              # defined in https://github.com/NixOS/nixpkgs/blob/481fbc1f6c7a089244732d605957b61b8415680b/nixos/modules/services/display-managers/regreet.nix#L163
              config.services.greetd.settings.default_session.command
              != "${lib.getExe' pkgs.dbus "dbus-run-session"} ${lib.getExe pkgs.cage} ${lib.escapeShellArgs cfg.cageArgs} -- ${lib.getExe cfg.package}"
          )
          "stylix: regreet: custom services.greetd.settings.default_session.command value may not work: ${config.services.greetd.settings.default_session.command}";
      services.displayManager.regreet.theme = {
        package = pkgs.adw-gtk3;
        name = "adw-gtk3";
      };
    }
    (
      { cfg, colors }:
      let
        baseCss = colors {
          # This is strongly inspired by ../gtk/gtk.mustache.
          template = ./gtk.css.mustache;
          extension = ".css";
        };

        finalCss = pkgs.runCommandLocal "gtk.css" { } ''
          cat ${baseCss} >>$out
          echo ${lib.escapeShellArg cfg.extraCss} >>$out
        '';
      in
      {
        services.displayManager.regreet.extraCss = finalCss.outPath;
      }
    )
    ({ polarity }: {
      services.displayManager.regreet.settings.GTK.application_prefer_dark_theme =
        polarity == "dark";
    })
    ({ image }: {
      services.displayManager.regreet.settings.background.path = image;
    })
    ({ imageScalingMode }: {
      services.displayManager.regreet.settings.background.fit =
        if imageScalingMode == "fill" then
          "Cover"
        else if imageScalingMode == "fit" then
          "Contain"
        else if imageScalingMode == "stretch" then
          "Fill"
        # No other available options
        else
          null;
    })
    ({ fonts }: {
      services.displayManager.regreet.font = {
        inherit (fonts.sansSerif) name package;
      };
    })
    ({ cursor }: {
      services.displayManager.regreet.cursorTheme = {
        inherit (cursor) name package;
      };
    })
    ({ polarity, icons }: {
      services.displayManager.regreet.iconTheme = {
        inherit (icons) package;
        name = if polarity == "dark" then icons.dark else icons.light;
      };
    })
  ];
}
