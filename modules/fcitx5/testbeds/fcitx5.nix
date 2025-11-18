{ pkgs, lib, ... }:
{
  stylix.testbed.ui.command.text = "fcitx5-config-qt";
  home-manager.sharedModules = lib.singleton {
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
      ];
    };
  };
}
