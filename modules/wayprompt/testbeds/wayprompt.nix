{ lib, ... }: {
  stylix.testbed = {
    # TODO: Re-enable once the upstream build failure [1] ("Build failure:
    # wayprompt") is resolved. Consider replacing wayprompt depending on
    # upstream decisions.
    #
    # [1]: https://github.com/NixOS/nixpkgs/issues/545176
    enable = false;

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
