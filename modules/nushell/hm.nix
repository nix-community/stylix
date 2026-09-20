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

      $env.config.highlight_resolved_externals = true;
      
      $env.config.color_config = {
        background: { bg: $base07 } # null for just terminal
        selection: { bg: $base02 }
        cursor: { fg: $base06 attr: r } # null for just terminal
        selection_cursor: { fg: $base06 attr: r }
        shape_matching_brackets: { fg: $base05 bg: $base02 attr: b }
      
        banner_foreground: $base05
        banner_highlight1: $base0B
        banner_highlight2: $base0E
      
        # foreground
        foreground: $base05 # null for just terminal
        shape_operator: $base05
        shape_block: { fg: $base05 attr: b }
        block: $base05 # reserved
        shape_closure: { fg: $base05 attr: b }
        closure: { fg: $base05 attr: b }
        shape_list: { fg: $base05 attr: b }
        list: $base05 # reserved
        shape_record: { fg: $base05 attr: b }
        record: $base05 # reserved
        shape_table: { fg: $base05 attr: b }
        shape_literal: $base05 # reserved
        empty: $base05
      
        # dim foreground
        # comments
        hints: $base03
        separator: $base03
      
        # other
        search_result: { bg: $base0A }
        leading_trailing_space_bg: { bg: $base0A }
        shape_garbage: { bg: $base08 attr: b }
      
        # binary
        shape_binary: { fg: $base0E attr: b }
        binary: $base0E
        binary_null_char: $base04
        binary_printable: { fg: $base0C attr: b }
        binary_whitespace: { fg: $base0B attr: b }
        binary_ascii_other: { fg: $base0E attr: b }
        binary_non_ascii: { fg: $base0A attr: b }
      
        # red
        shape_variable: $base08
        shape_vardecl: $base08
        shape_flag: { fg: $base08 attr: b }
        shape_externalarg: { fg: $base08 attr: b }
      
        # orange
        shape_nothing: $base09
        nothing: $base09
        shape_bool: $base09
        bool: $base09
        shape_int: { fg: $base09 attr: b }
        int: $base09
        shape_float: { fg: $base09 attr: b }
        float: $base09
        shape_range: { fg: $base09 attr: b }
        range: $base09
        shape_datetime: { fg: $base09 attr: b }
        datetime: $base09
        shape_custom: $base09
        custom: $base09
        duration: $base09
        filesize: $base09
        semver: { fg: $base09 attr: b }
        semver-range: { fg: $base09 attr: b }
      
        # yellow
        # classes
        header: { fg: $base0A attr: b }
        row_index: { fg: $base0A attr: b }
        shape_signature: { fg: $base0A attr: b }
      
        # green
        shape_string: $base0B
        string: $base0B
        shape_string_interpolation: { fg: $base0B attr: b }
        shape_raw_string: $base0B
        shape_directory: { fg: $base0B attr: b }
        shape_filepath: { fg: $base0B attr: b }
        shape_globpattern: { fg: $base0B attr: b }
        glob: { fg: $base0B attr: b }
        cell-path: $base0B
      
        # cyan
        # escape characters
      
        # blue
        shape_internalcall: { fg: $base0D attr: b }
        shape_external_resolved: $base0D
        shape_external: { fg: $base0D attr: i }
      
        # purple
        shape_keyword: { fg: $base0E attr: b } # reserved
        shape_pipe: { fg: $base0E attr: b }
        shape_redirection: { fg: $base0E attr: b }
        shape_match_pattern: $base0E
      }
      
      $env.config.explore = {
        selected_cell: { fg: $base0D attr: r }
        highlight: { fg: $base0A attr: r }
        status.success: { fg: $base0B attr: r }
        status.error: { fg: $base08 attr: r }
      }
      
      $env.config.menus = $env.config.menus | each { update style {
        text: $base0B
        selected_text: { fg: $base0B attr: r }
        description_text: $base0A
        match_text: $base0D
        selected_match_text: { fg: $base0D attr: r }
      }}
    '';
  };
}
