{ mkTarget, ... }:
mkTarget {
  name = "font-packages";
  humanName = "Font packages";

  config =
    { fonts }:
    {
      fonts = { inherit (fonts) packages; };
    };
}
