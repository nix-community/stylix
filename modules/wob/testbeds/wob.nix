{ lib, pkgs, ... }:
{
  stylix.testbed.ui = {
    graphicalEnvironment = "hyprland";
    command.text = lib.getExe (
      pkgs.writeShellScriptBin "wob-invoker" ''
        while true
        do
          for i in $(seq 0 200); do
            echo $i > $XDG_RUNTIME_DIR/wob.sock
            sleep 0.05
          done
        done
      ''
    );
  };

  home-manager.sharedModules = lib.singleton {
    services.wob = {
      enable = true;
      settings."" = {
        timeout = 5000;
      };
    };
  };
}
