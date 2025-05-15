{ lib, ... }:
{
  config.lib.stylix = {
    mkHexColor = color: "0x${lib.removePrefix "#" color}";

    mkOpacityHexColor =
      let
        opacityHex =
          percentage:
          lib.throwIfNot (percentage >= 0 && percentage <= 1)
            "value must be between 0 and 1 (inclusive): ${toString percentage}"
            (lib.toHexString (builtins.floor (percentage * 255 + 0.5)));
      in
      color: opacity: "0x${opacityHex opacity}${lib.removePrefix "#" color}";
  };
}
