# This package is currently only used on NixOS. On Home Manager we install the
# adw-gtk3 theme directly, then override it from $XDG_CONFIG_HOME, in a way
# that is not possible at the system level. Such an override avoids the need
# to patch libadwaita, but is not ideal because it doesn't make it clear
# (in settings and log output) that the upstream theme was modified by Stylix.
# The override also doesn't work in Flatpak.

{
  cfg,
  colors,
  adw-gtk3,
  runCommandLocal,
}:
runCommandLocal "stylix-gtk-theme"
  {
    baseCss = colors {
      template = ./gtk.css.mustache;
      extension = ".css";
    };
    inherit (cfg) extraCss;
    parent = "${adw-gtk3}/share/themes/adw-gtk3";
  }
  ''
    config="$out/etc/xdg"
    theme="$out/share/themes/Stylix"

    mkdir --parents \
      "$config/gtk-3.0" \
      "$config/gtk-4.0" \
      "$theme/gtk-3.0" \
      "$theme/gtk-4.0"

    cat >"$config/gtk-3.0/settings.ini" <<EOF
    [Settings]
    gtk-theme-name=Stylix
    EOF

    cat >"$config/gtk-4.0/settings.ini" <<EOF
    [Settings]
    gtk-theme-name=Stylix
    EOF

    cat >"$theme/index.theme" <<EOF
    [Desktop Entry]
    Name=Stylix
    Type=X-GNOME-Metatheme
    Encoding=UTF-8

    [X-GNOME-Metatheme]
    GtkTheme=Stylix
    EOF

    cat >"$theme/gtk-3.0/gtk.css" <<EOF
    @import url('$parent/gtk-3.0/gtk.css');
    @import url('$baseCss');
    $extraCss
    EOF

    cat >"$theme/gtk-3.0/gtk-dark.css" <<EOF
    @import url('$parent/gtk-3.0/gtk-dark.css');
    @import url('$baseCss');
    $extraCss
    EOF

    ln --symbolic \
      "$parent/gtk-3.0/assets" \
      "$theme/gtk-3.0/assets"

    cat >"$theme/gtk-4.0/gtk.css" <<EOF
    @import url('$parent/gtk-4.0/gtk.css');
    @import url('$baseCss');
    $extraCss
    EOF

    cat >"$theme/gtk-4.0/gtk-dark.css" <<EOF
    @import url('$parent/gtk-4.0/gtk-dark.css');
    @import url('$baseCss');
    $extraCss
    EOF

    ln --symbolic \
      "$parent/gtk-4.0/assets" \
      "$theme/gtk-4.0/assets"
  ''
