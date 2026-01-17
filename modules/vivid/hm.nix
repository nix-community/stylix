{ mkTarget, ... }:
mkTarget {
  config =
    { colors }:
    let
      theme = "stylix";
    in
    {
      programs.vivid = {
        activeTheme = theme;
        themes.${theme} = {
          colors = {
            inherit (colors)
              base00
              base01
              base02
              base03
              base04
              base05
              base06
              base07
              base08
              base09
              base0A
              base0B
              base0C
              base0D
              base0E
              base0F
              ;
          };

          core = {
            normal_text.foreground = "base04";

            reset_to_normal = {
              background = "base00";
              foreground = "base04";
              font-style = "regular";
            };

            # File Types

            regular_file.foreground = "base04";

            directory = {
              foreground = "base0F";
              font-style = "bold";
            };

            multi_hard_link = {
              foreground = "base0C";
              font-style = "underline";
            };

            symlink.foreground = "base0C";
            broken_symlink.foreground = "base08";

            missing_symlink_target = {
              background = "base08";
              foreground = "base05";
              font-style = "bold";
            };

            fifo = {
              foreground = "base07";
              font-style = [
                "bold"
                "underline"
              ];
            };

            character_device.foreground = "base0A";

            block_device = {
              foreground = "base0A";
              font-style = "underline";
            };

            door = {
              foreground = "base0A";
              font-style = "italic";
            };

            socket = {
              foreground = "base0A";
              font-style = "bold";
            };

            # File Permissions

            executable_file = {
              foreground = "base07";
              font-style = "bold";
            };

            file_with_capability = {
              foreground = "base04";
              font-style = [
                "bold"
                "underline"
              ];
            };

            setuid = {
              foreground = "base04";
              font-style = [
                "bold"
                "underline"
              ];
            };

            setgid = {
              foreground = "base04";
              font-style = [
                "bold"
                "underline"
              ];
            };

            sticky = {
              background = "base0F";
              foreground = "base05";
              font-style = "underline";
            };

            other_writable = {
              background = "base0F";
              foreground = "base05";
              font-style = "bold";
            };

            sticky_other_writable = {
              background = "base0F";
              foreground = "base05";
              font-style = [
                "bold"
                "underline"
              ];
            };
          };

          # Document Types

          archives = {
            foreground = "base05";
            font-style = "bold";
          };

          executable = {
            foreground = "base07";
            font-style = "bold";
          };

          markup = {
            foreground = "base06";
            web.foreground = "base04";
          };

          media = {
            foreground = "base0E";
            fonts.foreground = "base04";
          };

          office.foreground = "base0B";

          programming = {
            source.foreground = "base07";
            tooling.foreground = "base04";
          };

          text.foreground = "base04";
          unimportant.foreground = "base03";
        };
      };
    };
}
