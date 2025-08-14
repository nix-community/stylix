{ mkTarget, lib, ... }:
mkTarget {
  options.rainbow.enable = lib.mkEnableOption "rainbow gradient theming";

  config =
    { cfg, colors }:
    let
      mkGradient =
        colors:
        builtins.listToAttrs (
          lib.imap0 (
            i: c: lib.nameValuePair "gradient_color_${toString (i + 1)}" "'#${c}'"
          ) colors
        )
        // {
          gradient = 1;
          gradient_count = builtins.length colors;
        };
    in
    {
      programs.cava.settings.color = lib.mkIf cfg.rainbow.enable (
        mkGradient (
          with colors;
          [
            base0E
            base0D
            base0C
            base0B
            base0A
            base09
            base08
          ]
        )
      );
    };
}
