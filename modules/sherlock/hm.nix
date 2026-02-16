{ mkTarget, ... }:
mkTarget {
  config = [
    (
      { colors }:
      {
        programs.sherlock.style = with colors.withHashtag; ''
          :root {
              --background: ${base00};
              --background-alt: ${base05};

              --text: ${base05};
              --text-active: ${base00};

              /* accent colors */
              --success: ${base0B};
          }

          #search-icon-holder image,
          image.reactive {
            -gtk-icon-filter: brightness(1) opacity(0.8);
          }

          row:selected .tile image.reactive {
            -gtk-icon-filter: saturate(1.2) opacity(1) brightness(1.1);
          }

          /* Custom search icon animation */
          #search-icon-holder image {
            transition: 0.1s ease;
          }

          #search-icon-holder.search image:nth-child(1) {
            transition-delay: 0.05s;
            opacity: 1;
          }

          #search-icon-holder.search image:nth-child(2) {
            transform: rotate(-180deg);
            opacity: 0;
          }

          #search-icon-holder.back image:nth-child(1) {
            opacity: 0;
          }

          #search-icon-holder.back image:nth-child(2) {
            transition-delay: 0.05s;
            opacity: 1;
          }

          row:selected .tile #title {
            color: var(--text-active);
          }

          row:selected .tile .tag,
          .tag {
            border-radius: 3px;
            padding: 2px 8px;
            color: var(--tag-color);
            box-shadow: 0px 0px 10px 0px var(--background);
            border: 1px solid var(--text-active);
            margin-left: 7px;
          }

          row:selected .tile .tag-start,
          row:selected .tile .tag-start {
            background: var(--tag-background);
          }

          row:selected .tile .tag-end,
          row:selected .tile .tag-end {
            background: var(--success);
          }

          .tile:focus {
            outline: none;
          }

          #launcher-type {
            color: var(--text);
            margin-left: 0px;
          }

          row:selected .tile #launcher-type {
            background: var(--background-alt);
            color: var(--text-active);
          }

          row:selected .tile {
            background: var(--background-alt);
          }

          /*SHORTCUT*/
          #shortcut-holder {
            margin-right: 25px;
            padding: 5px 10px;
            background: var(--background-alt);
            border-radius: 5px;
            border: 1px solid hsl(from var(--text) h s l / 10%);
            box-shadow: 0px 0px 6px 0px rgba(15, 15, 15, 1);
          }

          row:selected .tile #shortcut-holder {
            background: var(--background);
          }

          row:selected .tile #shortcut-holder label {
            color: var(--text);
          }

          #shortcut-holder {
            box-shadow: unset;
          }

          #shortcut-holder label {
            color: var(--text-active);
          }

          /* BULK TEXT TILE */
          .bulk-text {
            padding-bottom: 10px;
            min-height: 50px;
          }

          #bulk-text-title {
            margin-left: 10px;
            padding: 10px 0px;
            color: var(--text);
          }

          #bulk-text-content-title {
            font-weight: bold;
            color: var(--text-active);
            min-height: 20px;
          }

          #bulk-text-content-body {
            font-size: 14px;
            color: var(--text-active);
            line-height: 1.4;
            min-height: 20px;
          }

          /*EVENT TILE*/
          .tile.event-tile:selected #time-label,
          .tile.event-tile:selected #title-label {
            color: var(--text-active);
          }

          /* NEXT PAGE */
          .next_tile {
            color: var(--text-active);
            background: var(--background);
          }

          .next_tile #content-body {
            background: var(--background);
            padding: 10px;
            color: var(--text);
          }

          /* CONTEXT MENU */
          #context-menu row:selected label {
            color: var(--text-active);
          }

          /* STATUS BAR */
          .status-bar #shortcut-key,
          .status-bar #shortcut-modifier {
            color: var(--text-active);
          }

          /* EMOJIES */
          .emoji-item {
            background: var(--background-alt);
          }
        '';
      }
    )
    (
      { fonts }:
      {
        programs.sherlock.style = ''
          row:selected .tile .tag,
          .tag {
              font-size: ${toString fonts.sizes.popups}px;
          }

          #launcher-type {
              font-size: ${toString fonts.sizes.popups}px;
          }

          #shortcut-modkey {
              font-size: ${toString fonts.sizes.popups}px;
          }

          #bulk-text-title {
              font-size: ${toString fonts.sizes.popups}px;
          }

          #bulk-text-content-title {
              font-size: ${toString fonts.sizes.popups}px;
          }

          .raw_text,
          .next_tile #content-body {
              font-family: "${fonts.monospace.name}", monospace;
          }
        '';
      }
    )
  ];
}
