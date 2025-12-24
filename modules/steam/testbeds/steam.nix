{
  config,
  lib,
  pkgs,
  ...
}:

{
  stylix.testbed = {
    enable = pkgs.stdenv.hostPlatform.system == "x86_64-linux";
    ui.command = {
      text = "steam";
      useTerminal = true;
    };
    ui.application = {
      name = "io.github.Foldex.AdwSteamGtk";
      package = pkgs.adwsteamgtk;
    };
  };

  virtualisation.vmVariant.virtualisation = {
    cores = 4;
    memorySize = 2 * 1024;
    diskSize = 3 * 1024;
  };

  programs.steam.enable = true;

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-unwrapped"
    ];
}
