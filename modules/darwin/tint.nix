mkTarget:
{ lib, ... }:
let
  mkDarwinColor =
    color:
    let
      mkChannel = start: builtins.toJSON ((lib.fromHexString (builtins.substring start 2 color)) / 255.0);
    in
    builtins.concatStringsSep " " [
      (mkChannel 0)
      (mkChannel 2)
      (mkChannel 4)
      "1.0"
    ];
in
mkTarget {
  name = "darwin";
  humanName = "Darwin";

  configElements =
    { colors }:
    {
      targets.darwin.defaults."Apple Global Domain".AppleIconAppearanceCustomTintColor =
        mkDarwinColor colors.base00;
    };
}
