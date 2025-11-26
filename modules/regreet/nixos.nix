{
  mkTarget,
  pkgs,
  config,
  lib,
  ...
}:
mkTarget {
  name = "regreet";
  humanName = "ReGreet";

  autoEnable = pkgs.stdenv.hostPlatform.isLinux;
  autoEnableExpr = "pkgs.stdenv.hostPlatform.isLinux";

  extraOptions = {
    useWallpaper = config.lib.stylix.mkEnableWallpaper "ReGreet" true;
    extraCss = lib.mkOption {
      description = ''
        Extra code added to `programs.regreet.extraCss` option.
      '';
      type = lib.types.lines;
      default = "";
      example = "window.background { border-radius: 0; }";
    };
  };

  configElements = [
    {
      warnings =
        let
          cfg = config.programs.regreet;
        in
        lib.optional
          (
            cfg.enable
            &&
              # defined in https://github.com/NixOS/nixpkgs/blob/8f3e1f807051e32d8c95cd12b9b421623850a34d/nixos/modules/programs/regreet.nix#L153
              config.services.greetd.settings.default_session.command
              != "${lib.getExe' pkgs.dbus "dbus-run-session"} ${lib.getExe pkgs.cage} ${lib.escapeShellArgs cfg.cageArgs} -- ${lib.getExe cfg.package}"
          )
          "stylix: regreet: custom services.greetd.settings.default_session.command value may not work: ${config.services.greetd.settings.default_session.command}";
      programs.regreet.theme = {
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
        programs.regreet.extraCss = finalCss.outPath;
      }
    )
    (
      { polarity }:
      {
        programs.regreet.settings.GTK.application_prefer_dark_theme =
          polarity == "dark";
      }
    )
    (
      { cfg, image }:
      {
        programs.regreet.settings.background.path = lib.mkIf cfg.useWallpaper image;
      }
    )
    (
      { cfg, imageScalingMode }:
      {
        programs.regreet.settings.background.fit = lib.mkIf cfg.useWallpaper (
          if imageScalingMode == "fill" then
            "Cover"
          else if imageScalingMode == "fit" then
            "Contain"
          else if imageScalingMode == "stretch" then
            "Fill"
          # No other available options
          else
            null
        );
      }
    )
    (
      { fonts }:
      {
        programs.regreet.font = {
          inherit (fonts.sansSerif) name package;
        };
      }
    )
    (
      { cursor }:
      {
        programs.regreet.cursorTheme = {
          inherit (cursor) name package;
        };
      }
    )
    (
      { polarity, icons }:
      {
        programs.regreet.iconTheme = {
          inherit (icons) package;
          name = if (polarity == "dark") then icons.dark else icons.light;
        };
      }
    )
  ];
}
