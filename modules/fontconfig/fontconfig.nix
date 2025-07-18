{ mkTarget, lib, ... }:
mkTarget {
  name = "fontconfig";
  humanName = "Fontconfig";

  configElements =
    { fonts }:
    {
      fonts.fontconfig.defaultFonts = lib.genAttrs [
        "monospace"
        "serif"
        "sansSerif"
        "emoji"
      ] (family: [ fonts.${family}.name ]);
    };
}
