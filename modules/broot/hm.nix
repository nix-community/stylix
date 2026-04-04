{ mkTarget, ... }:
mkTarget {
  config =
    { colors }:
    {
      programs.broot.settings = {
        # Override import section to force custom skin to be used
        imports = [ ];

        skin = with colors.withHashtag; {
          default = "${base05} ${base00}";
          tree = "${base02} ${base00}";
          parent = "${base04} ${base00}";
          file = "${base05} ${base00}";
          directory = "${base0D} ${base00}";
          exe = "${base0B} ${base00}";
          link = "${base0C} ${base00}";
          pruning = "${base04} ${base00} Italic";
          perm__ = "${base04} ${base00}";
          perm_r = "${base0C} ${base00}";
          perm_w = "${base09}";
          perm_x = "${base0B} ${base00}";
          owner = "${base07} ${base00}";
          group = "${base0E} ${base00}";
          count = "${base09} ${base00}";
          dates = "${base0C} ${base00}";
          sparse = "${base0A} ${base00}";
          content_extract = "${base0C} ${base00}";
          content_match = "${base0B} ${base00}";
          device_id_major = "${base07} ${base00}";
          device_id_sep = "${base04} ${base00}";
          device_id_minor = "${base07} ${base00}";

          git_branch = "${base0E} ${base00}";
          git_insertions = "${base0B} ${base00}";
          git_deletions = "${base08} ${base00}";
          git_status_current = "${base05} ${base00}";
          git_status_modified = "${base0A} ${base00}";
          git_status_new = "${base0C} ${base00} Bold";
          git_status_ignored = "${base04} ${base00}";
          git_status_conflicted = "${base08} ${base00}";
          git_status_other = "${base08} ${base00}";

          selected_line = "none ${base02}";
          char_match = "${base0B} ${base00} Bold";
          file_error = "${base08} ${base00}";

          flag_label = "${base05} ${base00}";
          flag_value = "${base0D} ${base00} Bold";

          input = "${base05} ${base00}";

          status_error = "${base04} ${base01}";
          status_job = "${base0A} ${base01}";
          status_normal = "${base04} ${base01}";
          status_italic = "${base0D} ${base01} Italic";
          status_bold = "${base0E} ${base01} Bold";
          status_code = "${base09} ${base01}";
          status_ellipsis = "${base05} ${base01}";

          purpose_normal = "${base05} ${base02}";
          purpose_italic = "${base0A} ${base02} Italic";
          purpose_bold = "${base0A} ${base02} Bold";
          purpose_ellipsis = "${base05} ${base02}";

          scrollbar_track = "${base04} ${base00}";
          scrollbar_thumb = "${base03} ${base00}";

          help_paragraph = "${base05} ${base00}";
          help_bold = "${base0E} ${base00} Bold";
          help_italic = "${base08} ${base00} Italic";
          help_code = "${base05} ${base04}";
          help_headers = "${base0E} ${base00}";
          help_table_border = "${base04} ${base00}";

          preview_title = "${base05} ${base00}";
          preview = "${base05} ${base01}";
          preview_separator = "${base0E} ${base00}";
          preview_line_number = "${base05} ${base01}";
          preview_match = "none ${base0B}";

          hex_null = "${base04} ${base00}";
          hex_ascii_graphic = "${base03} ${base00}";
          hex_ascii_whitespace = "${base0A} ${base00}";
          hex_ascii_other = "${base0A} ${base00}";
          hex_non_ascii = "${base08} ${base00}";

          staging_area_title = "${base05} ${base00}";
          mode_command_mark = "${base04} ${base08} Bold";

          good_to_bad_0 = base0B;
          good_to_bad_1 = base0B;
          good_to_bad_2 = base0C;
          good_to_bad_3 = base0D;
          good_to_bad_4 = base0A;
          good_to_bad_5 = base0A;
          good_to_bad_6 = base09;
          good_to_bad_7 = base0F;
          good_to_bad_8 = base08;
          good_to_bad_9 = base08;
        };
      };
    };
}
