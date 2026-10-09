{ config, ... }: {
  stylix = {
    fonts.sizes.applications.px = 15.5;
    testbed.ui.graphicalEnvironment = "gnome";
  };

  assertions = [
    {
      assertion =
        config.home-manager.users.guest.gtk.font.size == 11.625
        &&
          config.home-manager.users.guest.dconf.settings."org/gnome/desktop/interface".font-name
          == "${config.stylix.fonts.sansSerif.name} ${toString 11.625}";
      message = "Stylix must preserve fractional point sizes in GTK and GNOME.";
    }
  ];
}
