{ mkTarget, ... }:
mkTarget {
  name = "font-packages";
  humanName = "Font packages";

  config =
    { fonts }:
    {
      home = { inherit (fonts) packages; };
    };
}
