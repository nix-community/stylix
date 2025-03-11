{ config, lib,mkTarget, ... }:
mkTarget {
  name = "gnome-text-editor";
  humanName = "GNOME Text Editor";

  configElements = {
    dconf.settings."org/gnome/TextEditor".style-scheme = "stylix";
    warnings =
      lib.optional (!config.stylix.targets.gtksourceview.enable)
        "stylix: gnome-text-editor: This module will probably not work because the `gtksourceview' target is not enabled.";
  };
}
