{ mkTarget, ... }:
mkTarget {
  config = [
    ({ colors }: {
      wayland.windowManager.mango.settings =
        let
          hex = color: "0x${color}ff";
        in
        {
          rootcolor = hex colors.base00;
          bordercolor = hex colors.base03;
          dropcolor = "0x${colors.base00}55";
          splitcolor = hex colors.base0D;
          focuscolor = hex colors.base0D;
          urgentcolor = hex colors.base08;

          maximizescreencolor = hex colors.base0B;
          scratchpadcolor = hex colors.base0C;
          globalcolor = hex colors.base0E;
          overlaycolor = hex colors.base0C;

          jump_label_decorate_fg_color = hex colors.base05;
          jump_label_decorate_bg_color = hex colors.base01;
          jump_label_decorate_focus_fg_color = hex colors.base00;
          jump_label_decorate_focus_bg_color = hex colors.base0D;
          jump_label_decorate_border_color = hex colors.base0D;

          group_bar_decorate_fg_color = hex colors.base05;
          group_bar_decorate_bg_color = hex colors.base01;
          group_bar_decorate_focus_fg_color = hex colors.base00;
          group_bar_decorate_focus_bg_color = hex colors.base0D;
          group_bar_decorate_border_color = hex colors.base0D;
        };
    })
    ({ fonts }: {
      wayland.windowManager.mango.settings = {
        jump_label_decorate_font_desc = "${fonts.sansSerif.name} Bold 16";
        group_bar_decorate_font_desc = "${fonts.sansSerif.name} Bold 16";
      };
    })
  ];
}
