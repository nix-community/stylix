{ lib, ... }:
{
  stylix.testbed.ui.command.text = "halloy";

  home-manager.sharedModules = lib.singleton {
    programs.halloy = {
      enable = true;

      settings.servers.liberachat = {
        channels = [ "#halloy" ];
        nickname = "stylix-testbed";
        server = "irc.libera.chat";
      };
    };
  };
}
