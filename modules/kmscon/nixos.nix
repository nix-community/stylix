{
  mkTarget,
  lib,
  options,
  ...
}:
let
  hasConfigOption = options ? services.kmscon.config;
in
mkTarget {
  config = [
    (
      { fonts }:
      if hasConfigOption then
        {
          fonts.fontconfig.enable = true;
          fonts.packages = [ fonts.monospace.package ];
          services.kmscon.config = {
            font-name = fonts.monospace.name;
            font-size = toString fonts.sizes.terminal;
          };
        }
      else
        {
          services.kmscon = {
            fonts = [ fonts.monospace ];
            extraConfig = "font-size=${toString fonts.sizes.terminal}";
          };
        }
    )
    (
      { colors }:
      let
        formatBase =
          name:
          let
            getComponent = comp: colors."${name}-rgb-${comp}";
          in
          "${getComponent "r"},${getComponent "g"},${getComponent "b"}";

        palette = {
          palette = "custom";
          palette-black = formatBase "base00";
          palette-red = formatBase "base08";
          palette-green = formatBase "base0B";
          palette-yellow = formatBase "base0A";
          palette-blue = formatBase "base0D";
          palette-magenta = formatBase "base0E";
          palette-cyan = formatBase "base0C";
          palette-light-grey = formatBase "base05";
          palette-dark-grey = formatBase "base03";
          palette-light-red = formatBase "base08";
          palette-light-green = formatBase "base0B";
          palette-light-yellow = formatBase "base0A";
          palette-light-blue = formatBase "base0D";
          palette-light-magenta = formatBase "base0E";
          palette-light-cyan = formatBase "base0C";
          palette-white = formatBase "base07";
          palette-background = formatBase "base00";
          palette-foreground = formatBase "base05";
        };
      in
      if hasConfigOption then
        { services.kmscon.config = palette; }
      else
        { services.kmscon.extraConfig = lib.generators.toKeyValue { } palette; }
    )
  ];
}
