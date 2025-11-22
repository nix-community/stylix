{
  lib,
  pkgs,
  ...
}:
{
  stylix.testbed = {
    # Discord is not available on arm64.
    enable = lib.meta.availableOn pkgs.stdenv.hostPlatform pkgs.vesktop;

    ui.command.text = "discord";
  };

  home-manager.sharedModules = lib.singleton {
    programs.nixcord = {
      enable = true;
      discord = {
        enable = true;
        equicord.enable = true;
        vencord.enable = false;
      };
    };
  };

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "discord"
    ];
}
