{ mkTarget, lib, ... }:
mkTarget {
  name = "wob";

  options._opacity = lib.mkOption {
    type = lib.types.str;
    internal = true;
    default = "";
  };

  config = [
    (
      { opacity }:
      {
        stylix.targets.wob._opacity = lib.toHexString (
          builtins.floor (opacity.popups * 255 + 0.5)
        );
      }
    )

    (
      { cfg, colors }:
      {
        services.wob.settings = {
          "" = with colors; rec {
            border_color = base05 + cfg._opacity;
            background_color = base00 + cfg._opacity;
            bar_color = base0A;
            overflow_bar_color = base08;
            overflow_background_color = background_color;
            overflow_border_color = border_color;
          };
        };
      }
    )
  ];
}
