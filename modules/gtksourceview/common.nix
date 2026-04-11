{ lib, ... }:
{ colors, overlays }:
let
  style = colors {
    template = ./template.xml.mustache;
    extension = ".xml";
  };

  attrsOverride = version: oldAttrs: {
    postFixup = ''
      ${oldAttrs.postFixup or ""}
      styles_dir="$out/share/gtksourceview-${version}/styles"
      mkdir --parents "$styles_dir"
      cp ${style} "$styles_dir/stylix.xml"
    '';
  };
in
{
  nixpkgs.overlays = lib.singleton (
    _final: prev: {
      gnome2 = prev.gnome2 // {
        gtksourceview = prev.gnome2.gtksourceview.overrideAttrs (attrsOverride "2.0");
      };
      gtksourceview = prev.gtksourceview.overrideAttrs (attrsOverride "3.0");
      gtksourceview4 = prev.gtksourceview4.overrideAttrs (attrsOverride "4");
      gtksourceview5 = prev.gtksourceview5.overrideAttrs (attrsOverride "5");
    }
  );
}
