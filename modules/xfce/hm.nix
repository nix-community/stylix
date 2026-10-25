{ mkTarget, ... }:
mkTarget {
  # Disabled by default due to https://github.com/nix-community/stylix/issues/180
  autoEnable = false;

  config = { fonts }: {
    xfconf.settings = with fonts; {
      xfwm4 = {
        "general/title_font" = "${sansSerif.name} ${toString sizes.desktop.pt}";
      };
      xsettings = {
        "Gtk/FontName" = "${sansSerif.name} ${toString sizes.applications.pt}";
        "Gtk/MonospaceFontName" = "${monospace.name} ${toString sizes.applications.pt}";
      };
    };
  };
}
