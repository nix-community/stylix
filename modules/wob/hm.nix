{ mkTarget, lib, ... }:
mkTarget {
  config =
    { colors, opacity }:
    let
      wobOpacity = lib.fixedWidthString 2 "0" (
        lib.toHexString (builtins.ceil (opacity.popups * 255))
      );
    in
    {
      services.wob.settings = {
        "" = with colors; {
          border_color = "${base05}${wobOpacity}";
          background_color = "${base00}${wobOpacity}";
          bar_color = "${base0A}${wobOpacity}";
          overflow_bar_color = "${base08}${wobOpacity}";
          overflow_background_color = "${base00}${wobOpacity}";
          overflow_border_color = "${base05}${wobOpacity}";
        };
      };
    };
}
