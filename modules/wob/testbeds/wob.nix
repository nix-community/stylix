{ lib, pkgs, ... }: {
  stylix.testbed.ui = {
    graphicalEnvironment = "hyprland";
    command.text = lib.getExe (
      pkgs.writeShellScriptBin "wob-invoker" ''
        while true; do
          for percent in {0..200}; do
            echo "$percent" >"$XDG_RUNTIME_DIR/wob.sock"
            sleep 0.05
          done
        done
      ''
    );
  };

  home-manager.sharedModules = lib.singleton { services.wob.enable = true; };
}
