{
  lib,
  pkgs,
  config,
  ...
}:
{
  stylix.fonts.sizes = {
    desktop = 10;
    applications.px = 15.5;
    terminal.px = 13.5;
  };

  assertions = [
    {
      assertion =
        config.home-manager.users.guest.stylix.fonts.sizes.desktop.pt == 10.0;
      message = "Stylix must preserve legacy scalar font sizes through Home Manager inheritance.";
    }
    {
      assertion =
        config.home-manager.users.guest.programs.zed-editor.userSettings."buffer_font_size"
        == 13.5
        &&
          config.home-manager.users.guest.programs.zed-editor.userSettings."ui_font_size"
          == 15.5;
      message = "Stylix must preserve explicit NixOS font-size overrides through Home Manager inheritance.";
    }
  ];

  stylix.testbed.ui.command = {
    text = "${lib.getExe pkgs.zed-editor} flake-parts/flake.nix";
  };

  home-manager.sharedModules = lib.singleton {
    programs.zed-editor.enable = true;
  };
}
