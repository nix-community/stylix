{ mkTarget, ... }:
mkTarget {
  config = {
    # Required for Home Manager's GTK settings to work
    programs.dconf.enable = true;
  };
}
