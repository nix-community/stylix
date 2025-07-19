{
  mkTarget,
  config,
  lib,
  pkgs,
  ...
}:
mkTarget {
  options.useWallpaper = config.lib.stylix.mkEnableWallpaper "wayfire" true;

  config = [
    (
      { fonts }:
      {
        wayland.windowManager.wayfire.settings.decoration.font =
          "${fonts.monospace.name} ${toString fonts.sizes.desktop}";
      }
    )
    (
      {
        cfg,
        image,
        imageScalingMode,
      }:
      let
        wayfireBackground = pkgs.runCommand "wayfire-background.png" { } ''
          ${lib.getExe' pkgs.imagemagick "convert"} ${image} $out
        '';
      in
      {
        wayland.windowManager.wayfire.settings = {
          cube = {
            cubemap_image = lib.mkIf cfg.useWallpaper wayfireBackground;
            skydome_texture = lib.mkIf cfg.useWallpaper wayfireBackground;
          };
        };

        wayland.windowManager.wayfire.wf-shell.settings = {
          background.image = lib.mkIf cfg.useWallpaper wayfireBackground;
          background.fill_mode =
            if imageScalingMode == "stretch" then
              "stretch"
            else if imageScalingMode == "fit" then
              "preserve_aspect"
            else
              "fill_and_crop";
        };
      }
    )
    (
      { targets }:
      {
        wayland.windowManager.wayfire.wf-shell.settings.panel.menu_icon =
          lib.mkIf targets.nixos-icons.enable "${pkgs.nixos-icons}/share/icons/hicolor/256x256/apps/nix-snowflake.png";
      }
    )
    (
      { colors }:
      let
        rgba = rgb: a: "\\#${rgb}${a}";
        rgb = (lib.flip rgba) "ff";
      in
      {
        wayland.windowManager.wayfire = {
          settings = {
            cube = {
              background = rgb colors.base00;
            };

            expo.background = rgb colors.base00;
            vswitch.background = rgb colors.base00;
            vswipe.background = rgb colors.base00;
            core.background_color = rgb colors.base00;

            decoration = {
              active_color = rgb colors.base0D;
              inactive_color = rgb colors.base03;
            };
          };

          wf-shell.settings = {
            panel.background_color = rgb colors.base01;
          };
        };
      }
    )
  ];
}
