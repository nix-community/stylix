{ mkTarget, ... }:
mkTarget {
  name = "zathura";
  humanName = "Zathura";

  configElements =
    { colors, opacity }:
    {
      programs.zathura.options =
        let
          highlightTransparency = 0.5;
          getColorCh = colorName: channel: colors."${colorName}-rgb-${channel}";
          rgb =
            color:
            ''rgb(${getColorCh color "r"}, ${getColorCh color "g"}, ${getColorCh color "b"})'';
          rgba =
            color: alpha:
            ''rgba(${getColorCh color "r"}, ${getColorCh color "g"}, ${getColorCh color "b"}, ${toString alpha})'';
        in
        {
          # Taken from here:
          #   https://github.com/doenerkebap/base16-zathura
          default-bg = rgba "base00" opacity.applications;
          default-fg = rgb "base01";
          statusbar-fg = rgb "base04";
          statusbar-bg = rgb "base02";
          inputbar-bg = rgb "base00";
          inputbar-fg = rgb "base07";
          notification-bg = rgb "base00";
          notification-fg = rgb "base07";
          notification-error-bg = rgb "base00";
          notification-error-fg = rgb "base08";
          notification-warning-bg = rgb "base00";
          notification-warning-fg = rgb "base08";
          highlight-color = rgba "base0A" highlightTransparency;
          highlight-active-color = rgba "base0D" highlightTransparency;
          completion-bg = rgb "base01";
          completion-fg = rgb "base0D";
          completion-highlight-fg = rgb "base07";
          completion-highlight-bg = rgb "base0D";
          recolor-lightcolor = rgb "base00";
          recolor-darkcolor = rgb "base06";
        };
    };
}
