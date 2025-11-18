# NOTE: also used by /modules/zen-browser
{ name, lib }:
{ cfg, colors }:
{
  programs.${name}.profiles = lib.genAttrs cfg.profileNames (_: {
    settings = {
      "reader.color_scheme" = "custom";
      "reader.custom_colors.background" = colors.withHashtag.base00;
      "reader.custom_colors.foreground" = colors.withHashtag.base05;
      "reader.custom_colors.selection-highlight" = colors.withHashtag.base04;
      "reader.custom_colors.unvisited-links" = colors.withHashtag.base0D;
      "reader.custom_colors.visited-links" = colors.withHashtag.base0E;
    };
  });
}
