{ lib, ... }:
{
  stylix.testbed.ui = {
    graphicalEnvironment = "hyprland";
    command.text = "wlogout";
  };

  home-manager.sharedModules = lib.singleton (
    { config, ... }:
    {
      programs.wlogout.enable = true;
      stylix.targets.wlogout.addCss = false;
      # color definitions and font(size) set by stylix even with addCss = false
      programs.wlogout.style =
        let
          wlogoutDefaultLabels = [
            "hibernate"
            "lock"
            "logout"
            "reboot"
            "shutdown"
            "suspend"
          ];

          # use the coloredIcons exported by the stylix wlogout module in custom css
          mkLabelStyle = label: ''
            #${label} {
              background-image: url("${config.stylix.targets.wlogout.coloredIcons}/${label}.png");
            }
          '';

          labelStyles = lib.concatStringsSep "\n" (map mkLabelStyle wlogoutDefaultLabels);
        in
        ''
          button {
              border-color: @base03;
              text-decoration-color: @base05;
              color: @base05;
              background-color: @base02;
              border-style: solid;
              border-width: 5px;
              background-repeat: no-repeat;
              background-position: center;
              background-size: 50%;
            }
        ''
        + labelStyles;
    }
  );
}
