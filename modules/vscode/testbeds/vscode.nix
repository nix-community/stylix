{
  lib,
  pkgs,
  config,
  ...
}:
{
  stylix.fonts.sizes.terminal.px = 13.5;

  assertions = [
    {
      assertion =
        config.home-manager.users.guest.programs.vscode.profiles.default.userSettings."editor.fontSize"
        == 13.5;
      message = "Stylix must preserve fractional pixel font sizes in VS Code.";
    }
  ];

  stylix.testbed.ui.command.text = "code flake-parts/flake.nix";

  nixpkgs.config.allowUnfreePredicate =
    pkg: builtins.elem (lib.getName pkg) [ "vscode" ];

  home-manager.sharedModules = lib.singleton {
    programs.vscode = {
      package = pkgs.vscode;
      enable = true;
    };
  };
}
