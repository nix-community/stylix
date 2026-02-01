# This package is currently only used on NixOS. On Home Manager we install the
# adw-gtk3 theme directly, then override it from $XDG_CONFIG_HOME, in a way
# that is not possible at the system level. Such an override avoids the need
# to patch libadwaita, but is not ideal because it doesn't make it clear
# (in settings and log output) that the upstream theme was modified by Stylix.
# The override also doesn't work in Flatpak.

{
  cfg,
  colors,
  lib,
  adw-gtk3,
  linkFarm,
  writeText,
}:
let
  format = lib.generators.toINI { };

  settings = writeText "stylix-gtk-settings.ini" (format {
    Settings.gtk-theme-name = "Stylix";
  });

  index = writeText "stylix-gtk-index.theme" (format {
    "Desktop Entry" = {
      Encoding = "UTF-8";
      Name = "Stylix";
      Type = "X-GNOME-Metatheme";
    };
    X-GNOME-Metatheme.GtkTheme = "Stylix";
  });

  baseCss = colors {
    template = ./gtk.css.mustache;
    extension = ".css";
  };

  css =
    path:
    writeText "stylix-gtk-${path}" ''
      @import url('${adw-gtk3}/share/themes/adw-gtk3/${path}');
      @import url('${baseCss}');
      ${cfg.extraCss}
    '';
in
linkFarm "stylix-gtk" [
  {
    name = "etc/xdg/gtk-3.0/settings.ini";
    path = settings;
  }
  {
    name = "etc/xdg/gtk-4.0/settings.ini";
    path = settings;
  }
  {
    name = "share/themes/Stylix/index.theme";
    path = index;
  }
  {
    name = "share/themes/Stylix/gtk-3.0/assets";
    path = "${adw-gtk3}/share/themes/adw-gtk3/gtk-3.0/assets";
  }
  {
    name = "share/themes/Stylix/gtk-3.0/gtk.css";
    path = css "gtk-3.0/gtk.css";
  }
  {
    name = "share/themes/Stylix/gtk-3.0/gtk-dark.css";
    path = css "gtk-3.0/gtk-dark.css";
  }
  {
    name = "share/themes/Stylix/gtk-4.0/assets";
    path = "${adw-gtk3}/share/themes/adw-gtk3/gtk-4.0/assets";
  }
  {
    name = "share/themes/Stylix/gtk-4.0/gtk.css";
    path = css "gtk-4.0/gtk.css";
  }
  {
    name = "share/themes/Stylix/gtk-4.0/gtk-dark.css";
    path = css "gtk-4.0/gtk-dark.css";
  }
]
