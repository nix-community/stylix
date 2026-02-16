{ mkTarget, ... }:
mkTarget {
  config = [
    (
      { colors }:
      {
        programs.sherlock.style = with colors.withHashtag; ''
          :root {
              /* backgrounds */
              --background: ${base00};
              --text: ${base05};
              --text-active: ${base04};

              /* foreground */
              --foreground: ${base05};

              /* accent colors */
              --success: ${base0B};
          }

          #search-icon-holder image,
          image.reactive {
              -gtk-icon-filter: brightness(1) opacity(0.8);
          }

          row:selected .tile image.reactive {
              -gtk-icon-filter: saturate(1.2) opacity(1.0) brightness(1.1);
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
              color: hsl(from var(--text-active) h s l / 70%);
          }

          row:selected .tile .tag,
          .tag {
              border-radius: 3px;
              padding: 2px 8px;
              color: hsl(from var(--tag-color) h s l / 100%);
              box-shadow: 0px 0px 10px 0px hsl(from var(--background) h s l / 20%);
              border: 1px solid hsl(from var(--text-active) h s l / 20%);
              margin-left: 7px;
          }

          row:selected .tile .tag-start,
          row:selected .tile .tag-start {
              background: hsl(from var(--tag-background) h s l / 70%);
          }

          row:selected .tile .tag-end,
          row:selected .tile .tag-end {
              background: hsl(from var(--success) h s l / 100%);
          }

          .tile:focus {
              outline: none;
          }

          #launcher-type {
              color: hsl(from var(--text) h s l / 40%);
              margin-left: 0px;
          }

          row:selected .tile #launcher-type {
              color: hsl(from var(--text-active) h s l / 40%);
          }

          /*SHORTCUT*/
          #shortcut-holder {
              margin-right: 25px;
              padding: 5px 10px;
              background: hsl(from var(--foreground) h s l / 50%);
              border-radius: 5px;
              border: 1px solid hsl(from var(--text) h s l / 10%);
              box-shadow: 0px 0px 6px 0px rgba(15, 15, 15, 1);
          }

          row:selected .tile #shortcut-holder {
              background: hsl(from var(--background) h s l / 50%);
              background-color: hsl(from var(--background) h s l / 50%);
              color: hsl(from var(--text) h s l / 50%);
          }

          #shortcut-holder {
              box-shadow: unset;
          }

          #shortcut-holder label {
              color: hsl(from var(--text-active) h s l / 50%);
          }

          /* BULK TEXT TILE */
          .bulk-text {
              padding-bottom: 10px;
              min-height: 50px;
          }

          #bulk-text-title {
              margin-left: 10px;
              padding: 10px 0px;
              color: hsl(from var(--text) h s l / 50%);
          }

          #bulk-text-content-title {
              font-weight: bold;
              color: hsl(from var(--text-active) h s l / 70%);
              min-height: 20px;
          }

          #bulk-text-content-body {
              font-size: 14px;
              color: hsl(from var(--text-active) h s l / 70%);
              line-height: 1.4;
              min-height: 20px;
          }

          /*EVENT TILE*/
          .tile.event-tile:selected #time-label,
          .tile.event-tile:selected #title-label {
              color: hsl(from var(--text-active) h s l / 60%);
          }

          /* NEXT PAGE */
          .next_tile {
              color: hsl(from var(--text-active) h s l / 100%);
              background: hsl(from var(--background) h s l / 100%);
          }

          .next_tile #content-body {
              background: hsl(from var(--background) h s l / 100%);
              padding: 10px;
              color: hsl(from var(--text) h s l / 100%);
          }

          /* CONTEXT MENU */
          #context-menu row:selected label {
              color: hsl(from var(--text-active) h s l / 80%);
          }

          /* STATUS BAR */
          .status-bar #shortcut-key,
          .status-bar #shortcut-modifier {
              color: hsl(from var(--text-active) h s l / 50%);
          }

          /* EMOJIES */
          .emoji-item {
              background: hsl(from var(--foreground) h s l / 20%);
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
