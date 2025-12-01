{ pkgs, ... }:
{
  stylix.testbed.ui.command = {
    packages = with pkgs; [
      nsxiv
      xorg.xrdb
    ];

    text = ''
      # Xresources isn't loaded by default, so we force it
      xrdb ~/.Xresources

      nsxiv \
        "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg"
    '';
  };
}
