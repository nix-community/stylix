{ mkTarget, ... }:
mkTarget {
  config =
    { fonts }:
    {
      home = { inherit (fonts) packages; };
    };
}
