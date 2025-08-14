{ lib, pkgs, ... }:
{
  stylix.testbed =
    let
      package = pkgs.discord.override { withVencord = true; };
    in
    {
      enable = lib.meta.availableOn pkgs.stdenv.hostPlatform package;
      ui.command.packages = [ package ];
    };

  nixpkgs.config.allowUnfreePredicate =
    pkg: builtins.elem (lib.getName pkg) [ "discord" ];
}
