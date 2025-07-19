{ mkTarget, ... }:
mkTarget {
  config =
    { colors }:
    {
      xdg.configFile."forge/stylesheet/forge/stylesheet.css".source = colors {
        template = ./stylesheet.css.mustache;
        extension = ".css";
      };
    };
}
