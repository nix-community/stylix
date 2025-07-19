{ mkTarget, ... }:
mkTarget {
  config =
    { colors }:
    {
      dconf.settings."org/gnome/eog/view" = {
        # transparency = "background"; # Disables the grey and white check pattern.
        background-color = "#${colors.base00}";
      };
    };
}
