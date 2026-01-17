{ mkTarget, ... }:
mkTarget {
  config =
    { fonts }:
    {
      fonts = { inherit (fonts) packages; };
    };
}
