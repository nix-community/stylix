{ lib, ... }: {
  name = "Mango";
  homepage = "https://github.com/mangowm/mango";
  maintainers = [ lib.maintainers.darkguibrine ];

  description = ''
    Themes window borders, window state colors, overview jump mode, and the
    monocle tab bar, plus their fonts.

    This module requires the upstream Mango Home Manager module from the
    `github:mangowm/mango` flake input, since it sets
    `wayland.windowManager.mango.settings`, which is only available there and
    not in nixpkgs.
  '';
}
