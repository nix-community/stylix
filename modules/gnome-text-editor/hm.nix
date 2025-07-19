{ mkTarget, ... }:
mkTarget {
  name = "gnome-text-editor";
  humanName = "GNOME Text Editor";

  config = {
    dconf.settings."org/gnome/TextEditor".style-scheme = "stylix";
  };
}
