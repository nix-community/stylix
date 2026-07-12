{ mkTarget, ... }:
mkTarget {
  config =
    { colors }:
    {
      programs.aerc =
        let
          theme = "stylix";
        in
        {
          extraConfig.ui.styleset-name = theme;
          # Styling options documented in man aerc-stylesets(7).
          stylesets.${theme} = with colors.withHashtag; {
            global = {
              "*.default" = true;
              "*.normal" = true;

              "default.fg" = base05;
              "error.fg" = base08;
              "warning.fg" = base09;
              "success.fg" = base0B;

              "title.fg" = base07;
              "title.bold" = true;
              "header.fg" = base07;
              "header.bold" = true;

              "statusline_default.fg" = base04;
              "statusline_default.bg" = base01;
              "statusline_error.bold" = true;
              "statusline_success.bold" = true;

              "msglist_*.selected.bg" = base01;
              "msglist_*.selected.bold" = true;
              "msglist_unread.fg" = base07;
              "msglist_unread.bold" = true;
              "msglist_flagged.fg" = base0A;
              "msglist_flagged.bold" = true;
              "msglist_marked.bold" = true;
              "msglist_marked.reverse" = true;
              "msglist_result.fg" = base0D;
              "msglist_result.bold" = true;
              "msglist_pill.bg" = base01;

              "dirlist_*.selected.bg" = base01;
              "dirlist_*.selected.bold" = true;
              "dirlist_unread.bold" = true;

              "part_filename.fg" = base04;
              "part_mimetype.fg" = base03;
              "part_*.selected.bold" = true;
              "part_filename.selected.bg" = base01;
              "part_filename.selected.fg" = base05;
              "part_mimetype.selected.bg" = base01;
              "part_mimetype.selected.fg" = base04;

              "completion_*.bg" = base01;
              "completion_*.selected.bold" = true;
              "completion_pill.bg" = base02;

              "tab.fg" = base03;
              "tab.bg" = base00;
              "tab.selected.fg" = base05;
              "tab.selected.bg" = base01;
              "tab.selected.bold" = true;

              "border.fg" = base02;
              "border.bold" = true;

              "selector_focused.bold" = true;
            };

            viewer = {
              "*.default" = true;
              "*.normal" = true;

              "url.fg" = base0D;
              "url.underline" = true;
              "header.bold" = true;
              "signature.dim" = true;

              "diff_meta.bold" = true;
              "diff_chunk.fg" = base0D;
              "diff_chunk_func.fg" = base0D;
              "diff_chunk_func.bold" = true;
              "diff_add.fg" = base0B;
              "diff_del.fg" = base08;

              "quote_*.fg" = base03;
              "quote_1.fg" = base04;
            };
          };
        };
    };
}
