{ colors, colorScheme }: with colors;
''
  /* Stylix palette for the Thunderbird user interface. Thunderbird's own
     stylesheets take their colors from the custom properties below, so
     overriding them (plus `color-scheme`, which their `light-dark()` tokens
     resolve against) themes the folder pane, thread pane, tab bar and
     toolbars in one place. The names were read off Thunderbird's omni.ja
     (about3Pane.css and the shared stylesheets). */

  :root {
    color-scheme: ${colorScheme} !important;

    /* Panes and message area on base00, top chrome one step up. */
    --layout-background-0: #${base00-hex} !important;
    --layout-background-1: #${base00-hex} !important;
    --layout-background-3: #${base02-hex} !important;
    --layout-border-0: #${base02-hex} !important;
    --layout-border-1: #${base03-hex} !important;
    --layout-color-0: #${base05-hex} !important;
    --layout-color-1: #${base05-hex} !important;
    --layout-color-2: #${base04-hex} !important;
    --layout-color-3: #${base04-hex} !important;

    --sidebar-background: #${base00-hex} !important;
    --sidebar-color: #${base05-hex} !important;
    --sidebar-border: #${base02-hex} !important;
    --sidebar-highlight-background-color: #${base0D-hex} !important;
    --sidebar-highlight-text-color: #${base00-hex} !important;
    --sidebar-highlight-border-color: #${base0D-hex} !important;

    --toolbar-background-color: #${base01-hex} !important;
    --toolbar-text-color: #${base05-hex} !important;
    --toolbarbutton-icon-fill: #${base05-hex} !important;
    --chrome-content-separator-color: #${base02-hex} !important;
    --tabline-color: #${base0D-hex} !important;
    --splitter-color: #${base02-hex} !important;
    --lwt-text-color: #${base05-hex} !important;

    /* Buttons otherwise follow the platform accent (amber on some GTK
       themes), which has nothing to do with the palette. */
    --button-primary-background-color: #${base0D-hex} !important;
    --button-primary-text-color: #${base00-hex} !important;
    --button-primary-hover-background-color: #${base0E-hex} !important;
    --button-primary-active-background-color: #${base0B-hex} !important;
    --color-accent-primary: #${base0D-hex} !important;

    /* Selection follows Thunderbird's own model: accent-tinted while the
       pane has focus, a quiet raise while it does not. */
    --selected-item-color: #${base0D-hex} !important;
    --selected-item-text-color: #${base00-hex} !important;
    --treeitem-background-active: #${base0D-hex} !important;
    --treeitem-text-active: #${base00-hex} !important;
    --treeitem-background-selected: #${base02-hex} !important;
    --treeitem-background-hover: #${base01-hex} !important;
    --listbox-focused-selected-bg: #${base0D-hex} !important;
    --listbox-selected-color: #${base05-hex} !important;

    --list-container-background-selected: #${base02-hex} !important;
    --list-container-border-selected: #${base02-hex} !important;
    --list-container-background-selected-current: #${base02-hex} !important;
    --list-container-border-selected-current: #${base0D-hex} !important;
    --list-container-background-hover: #${base01-hex} !important;
    --list-container-border-hover: #${base02-hex} !important;
    --list-container-background-selected-focused: #${base02-hex} !important;
    --list-container-border-selected-focused: #${base0D-hex} !important;
    --list-container-border-selected-current-focused: #${base0D-hex} !important;
    --list-container-background-selected-current-focused: color-mix(
      in srgb,
      #${base0D-hex} 25%,
      #${base00-hex}
    ) !important;

    --tree-view-bg: #${base00-hex} !important;
    --tree-view-color: #${base05-hex} !important;

    /* Unread and "new messages" badges. */
    --folderpane-unread-count-background: #${base0D-hex} !important;
    --folderpane-unread-count-text: #${base00-hex} !important;
    --folderpane-total-count-background: #${base02-hex} !important;
    --folderpane-total-count-text: #${base04-hex} !important;
    --folderpane-unread-new-count-background: #${base0E-hex} !important;
    --new-folder-color: #${base0E-hex} !important;
  }

  /* Belt and braces: the badge colors above are plain custom properties, and
     any later !important rule (or a theme redefining them in a narrower
     scope) would still win. These selectors pin them where they are used. */
  #folderPane .unread-count,
  #folderPane .folder-count-badge {
    background-color: var(--folderpane-unread-count-background) !important;
    color: var(--folderpane-unread-count-text) !important;
  }

  #folderPane .total-count {
    background-color: var(--folderpane-total-count-background) !important;
    color: var(--folderpane-total-count-text) !important;
  }

  /* The top strip (tab bar, global search, window buttons) and the window's
     status bar (activity manager, Today Pane toggle) have no background of
     their own - #tabs-toolbar paints only a 1px separator gradient - and the
     native widget backgrounds they fall back on stop rendering under the
     forced dark color-scheme above. Paint them from the palette. */
  #messengerWindow,
  #titlebar,
  #tabs-toolbar,
  #unifiedToolbarContainer {
    background-color: var(--toolbar-background-color) !important;
  }

  #status-bar {
    background-color: var(--layout-background-1) !important;
  }
''
