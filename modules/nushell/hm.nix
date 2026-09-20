{ mkTarget, ... }:
mkTarget {
  config = { colors }: {
    programs.nushell.extraConfig = with colors.withHashtag; ''
      let base00 = "${base00}" # Default Background
      let base01 = "${base01}" # Lighter Background (Used for status bars, line number and folding marks)
      let base02 = "${base02}" # Selection Background
      let base03 = "${base03}" # Comments, Invisibles, Line Highlighting
      let base04 = "${base04}" # Dark Foreground (Used for status bars)
      let base05 = "${base05}" # Default Foreground, Caret, Delimiters, Operators
      let base06 = "${base06}" # Light Foreground (Not often used)
      let base07 = "${base07}" # Light Background (Not often used)
      let base08 = "${base08}" # Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
      let base09 = "${base09}" # Integers, Boolean, Constants, XML Attributes, Markup Link Url
      let base0A = "${base0A}" # Classes, Markup Bold, Search Text Background
      let base0B = "${base0B}" # Strings, Inherited Class, Markup Code, Diff Inserted
      let base0C = "${base0C}" # Support, Regular Expressions, Escape Characters, Markup Quotes
      let base0D = "${base0D}" # Functions, Methods, Attribute IDs, Headings
      let base0E = "${base0E}" # Keywords, Storage, Selector, Markup Italic, Diff Changed
      let base0F = "${base0F}" # Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>

      $env.config.menus = $env.config.menus | each { update style {
        text: $base0B
        selected_text: { fg: $base0B attr: r }
        description_text: $base0A
        match_text: $base0D
        selected_match_text: { fg: $base0D attr: r }
      }}

      $env.config.explore = {
        highlight: { fg: $base0A attr: r }
        status.success: { fg: $base0B attr: r }
        status.error: { fg: $base08 attr: r }
        selected_cell: { fg: $base0D attr: r }
      }

      $env.config.color_config = {
        # ?
        binary: $base08
        binary_ascii_other: $base0E
        binary_non_ascii: $base0A
        binary_null_char: $base02
        binary_printable: $base0C
        binary_whitespace: $base0B
        shape_binary: $base0E

        # red
        shape_variable: $base08
        shape_vardecl: $base08
        shape_flag: $base08
        shape_externalarg: $base08

        # orange
        shape_nothing: $base09
        nothing: $base09
        shape_bool: $base09
        bool: $base09
        shape_int: $base09
        int: $base09
        shape_float: $base09
        float: $base09
        shape_range: $base09
        range: $base09
        shape_datetime: $base09
        datetime: $base09
        shape_custom: $base09
        custom: $base09
        duration: $base09
        filesize: $base09
        semver: $base09
        semver-range: $base09

        # yellow
        # classes
        header: $base0A
        row_index: $base0A
        shape_signature: $base0A

        # green
        shape_string: $base0B
        string: $base0B
        shape_string_interpolation: $base0B
        shape_raw_string: $base0B
        shape_directory: { fg: $base0B attr: b }
        shape_filepath: { fg: $base0B attr: b }
        shape_globpattern: { fg: $base0B attr: b }
        glob: { fg: $base0B attr: b }
        cell-path: { fg: $base0B attr: b }

        # cyan
        # escape characters

        # blue
        shape_internalcall: { fg: $base0D attr: b }
        shape_external_resolved: $base0D
        shape_external: { fg: $base0D attr: i }

        # purple
        shape_keyword: $base0E # reserved
        shape_pipe: $base0E
        shape_redirection: $base0E
        shape_match_pattern: $base0E

        # foreground
        shape_operator: $base05
        shape_block: $base05
        block: $base05 # reserved
        shape_closure: $base05
        closure: $base05
        shape_list: $base05
        list: $base05 # reserved
        shape_record: $base05
        record: $base05 # reserved
        shape_table: $base05
        shape_literal: $base05 # reserved
        empty: $base05

        # dim foreground
        # comments
        hints: $base03
        separator: $base03

        # selection
        selection: { bg: $base02 }
        selection_cursor: { fg: $base06 attr: r }
        shape_matching_brackets: { fg: $base05 bg: $base02 attr: b }

        # other
        search_result: { bg: $base0A }
        leading_trailing_space_bg: { bg: $base0A }
        shape_garbage: { bg: $base08 }
      }
    '';
  };
}
