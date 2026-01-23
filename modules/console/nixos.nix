{ mkTarget, ... }:
mkTarget {
  config =
    { colors }:
    {
      console.colors = with colors; [
        base00-hex
        red
        green
        yellow
        blue
        magenta
        cyan
        base05-hex
        base03-hex
        red
        green
        yellow
        blue
        magenta
        cyan
        base07-hex
      ];
    };
}
