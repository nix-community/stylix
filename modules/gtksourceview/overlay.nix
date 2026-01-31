{ config, lib, ... }:
let
  inherit (lib) optionalAttrs;
  inherit (config.lib.stylix) colors;

  style = colors {
    template = ./template.xml.mustache;
    extension = ".xml";
  };

  joinOverride =
    final: oldPkg: version:
    final.symlinkJoin {
      pname = oldPkg.pname + "-stylix";
      paths = [ oldPkg ];
      inherit (oldPkg)
        version
        meta
        passthru
        propagatedBuildInputs
        ;
      postBuild = ''
        cp ${style} $out/share/gtksourceview-${version}/styles/stylix.xml
      '';
    };
in
{
  overlay =
    final: prev:
    optionalAttrs
      (
        config.stylix.enable
        && config.stylix.targets ? gtksourceview
        && config.stylix.targets.gtksourceview.enable
      )
      {
        gnome2 = prev.gnome2 // {
          gtksourceview = joinOverride final prev.gnome2.gtksourceview "2.0";
        };
        gtksourceview = joinOverride final prev.gtksourceview "3.0";
        gtksourceview4 = joinOverride final prev.gtksourceview4 "4";
        gtksourceview5 = joinOverride final prev.gtksourceview5 "5";
      };
}
