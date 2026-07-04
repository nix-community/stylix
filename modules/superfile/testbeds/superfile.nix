{ lib, pkgs, ... }:
{
  stylix.testbed.ui = {
    command = {
      text = lib.getExe pkgs.superfile;
      useTerminal = true;
    };
  };

  home-manager.sharedModules = lib.singleton {
    programs.superfile = {
      enable = true;
      firstUseCheck = false;
      settings = {
        auto_check_update = false;
        ignore_missing_fields = true;
        nerdfont = false;
      };
    };
  };
}
