{ mkTarget, ... }:
mkTarget {
  config = [
    (
      { colors }:
      {
        programs.aerc = {
          extraConfig.ui.styleset-name = "stylix";
          # Styling options documented in man aerc-stylesets(7).
          stylesets.stylix = with colors.withHashtag; {
            global = {
              "*.default" = true;
              "*.normal" = true;

              "default.fg" = base05;
              "error.fg" = base08;
              "warning.fg" = base09;
              "success.fg" = base0B;

              "tab.fg" = base03;
              "tab.bg" = base00;
              "tab.selected.fg" = base05;
              "tab.selected.bg" = base02;
              "tab.selected.bold" = true;

              "border.fg" = base02;
              "border.bold" = true;

              "msglist_unread.bold" = true;
              "msglist_flagged.fg" = base0A;
              "msglist_flagged.bold" = true;
              "msglist_result.fg" = base0D;
              "msglist_result.bold" = true;
              "msglist_*.selected.bg" = base01;
              "msglist_*.selected.bold" = true;

              "dirlist_*.selected.bg" = base01;
              "dirlist_*.selected.bold" = true;

              "statusline_default.fg" = base04;
              "statusline_default.bg" = base01;
              "statusline_error.bold" = true;
              "statusline_success.bold" = true;

              "selector_focused.bg" = base01;

              "completion_*.bg" = base01;
              "completion_*.selected.bold" = true;
            };

            viewer = {
              "*.default" = true;
              "*.normal" = true;

              "header.bold" = true;
              "signature.dim" = true;

              "diff_add.fg" = base0B;
              "diff_del.fg" = base08;
              "diff_chunk.fg" = base0D;
              "diff_chunk_func.fg" = base0D;
              "diff_chunk_func.bold" = true;
              "diff_meta.bold" = true;

              "quote_*.fg" = base03;
              "quote_1.fg" = base04;

              "url.fg" = base0D;
              "url.underline" = true;
            };
          };
        };
      }
    )
  ];
}
