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

  programs.steam.enable = true;

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-unwrapped"
    ];
}
