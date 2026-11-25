{ lib, pkgs, ... }: {
  stylix.testbed.ui = {
    command = {
      text = "${lib.getExe pkgs.superfile} flake-parts";
      useTerminal = true;
    };
  };

  home-manager.sharedModules = lib.singleton {
    programs.superfile = {
      enable = true;
      firstUseCheck = false;
      settings = {
        nerdfont = false;
      };
    };
  };
}
