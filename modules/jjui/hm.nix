{ mkTarget, lib, ... }:
mkTarget {
  config =
    { colors, polarity }:
    {
      programs.jjui.settings.ui.colors = with colors.withHashtag; {
        # Original template author: Victor Borja <vborja@apache.org> (https://github.com/vic)
        # See https://github.com/vic/tinted-jjui

        text.fg = base05;
        text.bg = base00;
        dimmed.fg = base03;
        dimmed.bg = base00;
        title.fg = base0D;
        title.bold = true;
        shortcut.fg = base0E;
        matched.fg = base0A;
        border.fg = base03;
        selected = {
          fg = base05;
          bg = base01;
          bold = true;
        };

        source_marker = {
          fg = base00;
          bg = base0C;
          bold = true;
        };
        target_marker = {
          fg = base00;
          bg = base0B;
          bold = true;
        };

        status.bg = base01;
        "status title" = {
          fg = base00;
          bg = base0D;
          bold = true;
        };

        "revset title" = {
          fg = base0D;
          bg = lib.mkIf (polarity != "dark") base01;
          bold = true;
        };
        "revset text".fg = base05;
        "revset text".bold = true;
        "revset completion text".fg = base05;
        "revset completion matched".fg = base0A;
        "revset completion matched".bold = true;
        "revset completion dimmed".fg = base03;
        "revset completion selected".bg = if polarity == "dark" then base02 else base06;
        "revset completion selected".fg = if polarity == "dark" then base05 else base02;

        revisions.fg = base05;
        "revisions selected".bg = if polarity == "dark" then base01 else base02;
        "revisions dimmed".fg = base03;
        "revisions details selected".bg = if polarity == "dark" then base02 else base04;
        "oplog selected".bold = true;

        evolog.fg = base05;
        "evolog selected" = {
          fg = if polarity == "dark" then base05 else base01;
          bg = if polarity == "dark" then base02 else base06;
          bold = true;
        };

        menu.bg = base00;
        "menu title" = {
          fg = base00;
          bg = base0E;
          bold = true;
        };
        "menu shortcut".fg = base0E;
        "menu matched".fg = base0A;
        "menu matched".bold = true;
        "menu dimmed".fg = base03;
        "menu border".fg = base01;
        "menu selected".fg = if polarity == "dark" then base05 else base01;
        "menu selected".bg = if polarity == "dark" then base02 else base06;

        help.bg = base00;
        "help title" = {
          fg = base0B;
          bold = true;
          underline = true;
        };
        "help border".fg = base01;

        preview.fg = base05;
        "preview border".fg = base01;

        confirmation.bg = base00;
        "confirmation text".fg = base0D;
        "confirmation text".bold = true;
        "confirmation dimmed".fg = base03;
        "confirmation border".fg = base08;
        "confirmation border".bold = true;
        "confirmation selected".fg = if polarity == "dark" then base05 else base01;
        "confirmation selected".bg = if polarity == "dark" then base02 else base06;

        undo.bg = base00;
        "undo confirmation dimmed".fg = base03;
        "undo confirmation selected".fg = if polarity == "dark" then base05 else base01;
        "undo confirmation selected".bg = if polarity == "dark" then base02 else base06;

        success.fg = base0B;
        success.bold = true;
        error.fg = base08;
        error.bold = true;
        "revisions rebase source_marker".bold = true;
        "revisions rebase target_marker".bold = true;
        "status shortcut".fg = base0E;
        "status dimmed".fg = base03;

        details.fg = base05;
        "details selected".bold = true;
        completion.fg = base05;
        "completion selected".bold = true;
        rebase.bold = true;

        workspace.fg = base0D;
        branch.fg = base09;
        commit.fg = base0B;
        file.fg = base0A;
        change.fg = base08;
        bookmark.fg = base0E;
      };
    };
}
