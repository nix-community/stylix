{ lib, ... }:
{
  stylix.testbed.ui = {
    command.text = ''
      wayprompt \
        --get-pin \
        --title "Wayprompt stylix test" \
        --description "Lorem ipsum dolor sit amet, consectetur adipiscing elit." \
        --button-ok "Okay" \
        --button-not-ok "Not okay" \
        --button-cancel "Cancel"
    '';

    graphicalEnvironment = "hyprland";
  };

  home-manager.sharedModules = lib.singleton {
    programs.wayprompt.enable = true;
  };
}
