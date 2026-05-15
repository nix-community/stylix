{
  config,
  lib,
  mkTarget,
  ...
}:
mkTarget {
  options =
    { image }:
    {
      hyprpaper.enable = config.lib.stylix.mkEnableTargetWith {
        name = "Hyprpaper";
        autoEnable = image != null;
        autoEnableExpr = "config.stylix.image != null";
      };
    };

  config = [
    (
      { colors }:
      {
        wayland.windowManager.hyprland.settings =
          let
            rgb = color: "rgb(${color})";
            rgba = color: alpha: "rgba(${color}${alpha})";
            colorSettings = {
              decoration.shadow.color = rgba colors.base00 "99";
              general = {
                col = {
                  active_border = rgb colors.base0D;
                  inactive_border = rgb colors.base03;
                };
              };
              group = {
                col = {
                  border_inactive = rgb colors.base03;
                  border_active = rgb colors.base0D;
                  border_locked_active = rgb colors.base0C;
                };

                groupbar = {
                  text_color = rgb colors.base05;
                  col = {
                    active = rgb colors.base0D;
                    inactive = rgb colors.base03;
                  };
                };
              };
              misc.background_color = rgb colors.base00;
            };
          in
          if config.wayland.windowManager.hyprland.configType == "lua" then
            { config = colorSettings; }
          else
            colorSettings;
      }
    )
    (
      { cfg }:
      lib.mkIf (config.wayland.windowManager.hyprland.enable && cfg.hyprpaper.enable)
        {
          services.hyprpaper.enable = true;
          stylix.targets.hyprpaper.enable = true;
          wayland.windowManager.hyprland.settings =
            if config.wayland.windowManager.hyprland.configType == "lua" then
              { config.misc.disable_hyprland_logo = true; }
            else
              { misc.disable_hyprland_logo = true; };
        }
    )
  ];
}
