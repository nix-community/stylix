{ pkgs, lib, ... }: {
  stylix.testbed.ui.command.text = lib.getExe pkgs.element-desktop;

  home-manager.sharedModules = lib.singleton {
    programs.element-desktop.enable = true;
  };
}
