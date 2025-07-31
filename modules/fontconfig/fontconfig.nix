{ mkTarget }:
{ lib, ... }:
mkTarget {
  name = "fontconfig";
  humanName = "Fontconfig";

  configElements =
    { listTargetIndex, fonts }:
    {
      fonts.fontconfig.defaultFonts = lib.genAttrs [
        "monospace"
        "serif"
        "sansSerif"
        "emoji"
      ] (family: lib.mkOrder listTargetIndex [ fonts.${family}.name ]);
    };
}
