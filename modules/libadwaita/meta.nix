{ lib, ... }:
{
  name = "Adwaita";
  homepage = "https://gnome.pages.gitlab.gnome.org/libadwaita";
  description = ''
    Adwaita is a widget library used by modern GNOME applications.

    It's based on [GTK 4](./gtk.html), but for compatibility reasons,
    applications made with it do not allow customization and will always load
    the standard Adwaita theme. This module patches the source code to permit
    loading other themes.

    > [!WARNING]
    > Theming is [explicitly unsupported](https://stopthemingmy.app) by many
    > upstream developers. Please do not bother them with bugs related to this.
  '';
  maintainers = [ lib.maintainers.danth ];
}
