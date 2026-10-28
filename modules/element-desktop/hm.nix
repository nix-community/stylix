{ mkTarget, lib, ... }:
mkTarget {
  config = [
    (
      {
        colors,
        fonts,
        polarity,
      }:
      with colors.withHashtag;
      {
        programs.element-desktop.settings = {
          default_theme = lib.mkDefault "custom-Stylix";
          setting_defaults.custom_themes = [
            {
              name = "Stylix";
              fonts = {
                general = "'${fonts.sansSerif.name}', sans-serif";
                monospace = "'${fonts.monospace.name}', monospace";
              };
              is_dark = polarity == "dark";
              colors = {
                accent-color = base0D;
                primary-color = base0D;
                warning-color = base08;
                sidebar-color = base01;
                roomlist-background-color = base01;
                roomlist-text-color = base05;
                roomlist-text-secondary-color = base04;
                roomlist-highlights-color = base02;
                roomlist-separator-color = base03;
                timeline-background-color = base00;
                timeline-text-color = base05;
                timeline-text-secondary-color = base04;
                timeline-highlights-color = base01;
                username-colors = [
                  base08
                  base09
                  base0A
                  base0B
                  base0C
                  base0D
                  base0E
                  base0F
                ];
                avatar-background-colors = [
                  base08
                  base09
                  base0A
                  base0B
                  base0C
                  base0D
                  base0E
                  base0F
                ];
              };
            }
          ];
        };
      }
    )
  ];
}
