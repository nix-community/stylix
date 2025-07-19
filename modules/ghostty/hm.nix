# Documentation is available at:
# - https://ghostty.org/docs/config/reference
# - `man 5 ghostty`
{ mkTarget, pkgs, ... }:
mkTarget {
  name = "ghostty";
  humanName = "Ghostty";

  config = [
    (
      { fonts }:
      {
        programs.ghostty.settings = {
          font-family = [
            fonts.monospace.name
            fonts.emoji.name
          ];

          # Ghostty font-size is specified in points (pt) on all platforms.
          # Ghostty's default DPI is 96 on Linux and 72 on macOS.
          # fonts.sizes.terminal is in pt size so no changes on Linux are needed,
          # but to match visual size on macOS we scale it by 4/3 = 96/72.
          font-size =
            if pkgs.stdenv.hostPlatform.isDarwin then
              fonts.sizes.terminal * 4.0 / 3.0
            else
              fonts.sizes.terminal;
        };
      }
    )
    (
      { opacity }:
      {
        programs.ghostty.settings = {
          background-opacity = opacity.terminal;
        };
      }
    )
    (
      { colors }:
      {
        programs.ghostty = {
          settings.theme = "stylix";
          themes.stylix = {
            background = colors.base00;
            foreground = colors.base05;
            cursor-color = colors.base05;
            selection-background = colors.base02;
            selection-foreground = colors.base05;

            palette = with colors.withHashtag; [
              "0=${base00}"
              "1=${base08}"
              "2=${base0B}"
              "3=${base0A}"
              "4=${base0D}"
              "5=${base0E}"
              "6=${base0C}"
              "7=${base05}"
              "8=${base03}"
              "9=${base08}"
              "10=${base0B}"
              "11=${base0A}"
              "12=${base0D}"
              "13=${base0E}"
              "14=${base0C}"
              "15=${base07}"
            ];
          };
        };
      }
    )
  ];
}
