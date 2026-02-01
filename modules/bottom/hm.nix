{ mkTarget, lib, ... }:
mkTarget {
  config =
    { colors }:
    {
      programs.bottom.settings.styles = with colors.withHashtag; {
        cpu = {
          all_entry_color = base0C;
          avg_entry_color = base08;
          cpu_core_colors = [
            base08
            base09
            base0A
            base0B
            base0C
            base0D
            base0E
          ];
        };
        memory = {
          ram_color = base0B;
          cache_color = base08;
          swap_color = base09;
          gpu_colors = [
            base0C
            base0E
            base08
            base09
            base0A
            base0B
          ];
          arc_color = base0D;
        };
        network = {
          rx_color = base0B;
          tx_color = base08;
          rx_total_color = base0D;
          tx_total_color = base0B;
        };
        battery = {
          high_battery_color = base0B;
          medium_battery_color = base0A;
          low_battery_color = base08;
        };
        tables.headers.color = base06;
        graphs.graph_color = base05;
        legend_text.color = base05;
        widgets = {
          border_color = base03;
          selected_border_color = base0D;
          widget_title.color = base05;
          text.color = base05;
          selected_text = {
            color = base0D;
            bg_color = base03;
          };
          disabled_text.color = base02;
        };
      };
    };
}
