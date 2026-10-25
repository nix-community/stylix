{ lib, pkgs, ... }: {
  stylix.testbed.ui.command = {
    text = lib.getExe pkgs.pi-coding-agent;
    useTerminal = true;
  };

  home-manager.sharedModules = lib.singleton {
    programs.pi-coding-agent.enable = true;
  };
}
