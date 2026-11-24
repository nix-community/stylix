{
  mkTarget,
  pkgs,
  lib,
  ...
}:
mkTarget {
  options.extraCss = lib.mkOption {
    description = ''
      Extra code added to `gtk-3.0/gtk.css` and `gtk-4.0/gtk.css`.
    '';
    type = lib.types.lines;
    default = "";
    example = ''
      // Remove rounded corners
      window.background { border-radius: 0; }
    '';
  };

  config = [
    {
      # Required for Home Manager's GTK settings to work
      programs.dconf.enable = true;
    }

    (
      { cfg, colors }:
      {
        environment.systemPackages = lib.singleton (
          pkgs.callPackage ./theme.nix { inherit cfg colors; }
        );

        # Under GNOME on Wayland, the XDG Desktop Portal implementation takes
        # priority over the settings files in `$XDG_CONFIG_DIRS/etc/xdg` [1],
        # reading from this DConf path instead.
        #
        # [1] https://docs.gtk.org/gtk4/class.Settings.html
        programs.dconf.profiles.user.databases = lib.singleton {
          settings."org/gnome/desktop/interface".gtk-theme = "Stylix";
        };
      }
    )
  ];
}
