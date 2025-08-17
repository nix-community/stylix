{ lib, ... }:
{
  stylix.testbed = {
    ui.graphicalEnvironment = "hyprland";
    ui.command.text = ''
      wayprompt \
        --get-pin \
        --title "Wayprompt stylix test" \
        --description "Lorem ipsum dolor sit amet, consectetur adipiscing elit." \
        --button-ok "Okay" \
        --button-not-ok "Not okay" \
        --button-cancel "Cancel"
    '';
  };

  home-manager.sharedModules = lib.singleton {
    programs.wayprompt.enable = true;
  };
}
