{ lib, ... }:
{
  name = "GTK";
  homepage = "https://gtk.org";
  description = ''
    GTK is a widget library used by many applications.

    This module installs three things:

    - A GTK 4 theme based on
      [Adwaita](https://gnome.pages.gitlab.gnome.org/libadwaita/),
      modified to use your colors.
    - A GTK 3 theme based on
      [adw-gtk3](https://github.com/lassekongo83/adw-gtk3#readme),
      modified to use your colors.
    - A settings file listing your fonts.

    Older versions of GTK are not supported.

    Modern GNOME applications must be [patched](./libadwaita.html) to allow
    loading custom themes.

    > [!WARNING]
    > Theming is [explicitly unsupported](https://stopthemingmy.app) by many
    > upstream developers. Please do not bother them with bugs related to this.
  '';
  maintainers = [ lib.maintainers.danth ];
}
