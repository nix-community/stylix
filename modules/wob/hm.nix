{ mkTarget, lib, ... }:
mkTarget {
  config =
    { colors, opacity }:
    let
      opacity' = lib.toHexString (builtins.ceil (opacity.popups * 255));
    in
    {
      services.wob.settings = {
        "" = with colors; {
          border_color = base05 + opacity';
          background_color = base00 + opacity';
          bar_color = base0A;
          overflow_bar_color = base08;
          overflow_background_color = base00;
          overflow_border_color = base05;
        };
      };
    };
}
