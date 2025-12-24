{
  config,
  lib,
  pkgs,
  ...
}:

{
  stylix.testbed = {
    enable = pkgs.stdenv.hostPlatform.system == "x86_64-linux";
    ui.application = {
      name = "steam";
      inherit (config.programs.steam) package;
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
