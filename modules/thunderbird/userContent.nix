{ colors, colorScheme }: with colors;
''
  /* Stylix palette for message content and Thunderbird's own content pages
     (settings, account setup). Deliberately without `!important`: any rule a
     message brings itself keeps priority, so only plain documents and the
     default canvas pick these colors up. The `light-dark()` tokens of the
     content pages follow `color-scheme` below. */

  :root {
    color-scheme: ${colorScheme};
  }

  body {
    background-color: #${base00-hex};
    color: #${base05-hex};
  }

  a {
    color: #${base0D-hex};
  }

  a:visited {
    color: #${base0B-hex};
  }

  blockquote,
  .moz-quote {
    color: #${base04-hex};
  }
''
