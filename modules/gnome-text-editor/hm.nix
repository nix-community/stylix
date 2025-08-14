{ mkTarget, ... }:
mkTarget {
  config = {
    dconf.settings."org/gnome/TextEditor".style-scheme = "stylix";
  };
}
