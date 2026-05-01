_: {
  semantic2base16 =
    { polarity, palette }:
    {
      inherit polarity;
      palette = palette // {
        base16 =
          let
            mapping =
              if polarity == "dark" then
                {
                  base00 = "surface_container_lowest";
                  base01 = "surface_container";
                  base02 = "surface_container_highest";
                  base03 = "outline";
                  base04 = "on_surface_variant";
                  base05 = "on_surface";
                  base06 = "secondary_fixed";
                  base07 = "primary";
                  base08 = "error";
                  base09 = "tertiary";
                  base0A = "secondary";
                  base0B = "primary";
                  base0C = "primary_fixed";
                  base0D = "surface_tint";
                  base0E = "tertiary_fixed";
                  base0F = "on_error_container";
                }
              else
                {
                  base00 = "surface";
                  base01 = "surface_container";
                  base02 = "surface_container_highest";
                  base03 = "outline";
                  base04 = "on_surface_variant";
                  base05 = "on_surface";
                  base06 = "tertiary_container";
                  base07 = "on_primary_fixed_variant";
                  base08 = "error";
                  base09 = "tertiary";
                  base0A = "secondary";
                  base0B = "primary";
                  base0C = "primary_container";
                  base0D = "surface_tint";
                  base0E = "secondary_fixed_dim";
                  base0F = "inverse_surface";
                };
          in
          builtins.mapAttrs (_: role: palette.semantic.${role}) mapping;
      };
    };
  # The following two mappings are built from the tables here (https://github.com/tinted-theming/base24/blob/fb96d3c6396eb27f94efadfa3c416abd9d54b488/future.md)
  # base24 is a superset of base16, inherit base24 vals for this mapping
  base242base16 =
    { polarity, palette }:
    {
      inherit polarity;
      palette = palette // {
        base16 = builtins.removeAttrs palette.base24 [
          "base10"
          "base11"
          "base12"
          "base13"
          "base14"
          "base15"
          "base16"
          "base17"
        ];
      };
    };
  # and fill in the extra colors using the table for this mapping
  base162base24 =
    { polarity, palette }:
    {
      inherit polarity;
      palette = palette // {
        base24 =
          let
            b16 = palette.base16;
          in
          b16
          // {
            base10 = b16.base00;
            base11 = b16.base00;
            base12 = b16.base08;
            base13 = b16.base0A;
            base14 = b16.base0B;
            base15 = b16.base0C;
            base16 = b16.base0D;
            base17 = b16.base0E;
          };
      };
    };
}
