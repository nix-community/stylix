{ mkTarget, ... }:
mkTarget {
  config =
    { colors }:
    {
      programs.eza.theme = {
        punctuation.foreground = colors.base05;
        punctuation.background = colors.base00;
        date.foreground = colors.base05;
        date.background = colors.base00;
        inode.foreground = colors.base05;
        inode.background = colors.base00;
        blocks.foreground = colors.base05;
        blocks.background = colors.base00;
        header.foreground = colors.base05;
        header.background = colors.base00;
        octal.foreground = colors.base05;
        octal.background = colors.base00;
        flags.foreground = colors.base05;
        flags.background = colors.base00;
        control_char.foreground = colors.base05;
        control_char.background = colors.base00;
        broken_symlink.foreground = colors.base08;
        broken_symlink.background = colors.base00;
        broken_path_overlay.foreground = colors.base08;
        broken_path_overlay.background = colors.base00;

        filekinds = {
          normal.foreground = colors.base05;
          normal.background = colors.base00;
          directory.foreground = colors.base0C;
          directory.background = colors.base00;
          symlink.foreground = colors.base0D;
          symlink.background = colors.base00;
          pipe.foreground = colors.base0A;
          pipe.background = colors.base00;
          block_device.foreground = colors.base09;
          block_device.background = colors.base00;
          char_device.foreground = colors.base09;
          char_device.background = colors.base00;
          socket.foreground = colors.base0E;
          socket.background = colors.base00;
          special.foreground = colors.base08;
          special.background = colors.base00;
          executable.foreground = colors.base0B;
          executable.background = colors.base00;
          mount_point.foreground = colors.base0F;
          mount_point.background = colors.base00;
        };
        perms = {
          user_read.foreground = colors.base05;
          user_read.background = colors.base00;
          user_write.foreground = colors.base0B;
          user_write.background = colors.base00;
          user_execute_file.foreground = colors.base0B;
          user_execute_file.background = colors.base00;
          user_execute_other.foreground = colors.base0B;
          user_execute_other.background = colors.base00;
          group_read.foreground = colors.base05;
          group_read.background = colors.base00;
          group_write.foreground = colors.base0B;
          group_write.background = colors.base00;
          group_execute.foreground = colors.base0B;
          group_execute.background = colors.base00;
          other_read.foreground = colors.base05;
          other_read.background = colors.base00;
          other_write.foreground = colors.base0B;
          other_write.background = colors.base00;
          other_execute.foreground = colors.base0B;
          other_execute.background = colors.base00;
          special_user_file.foreground = colors.base08;
          special_user_file.background = colors.base00;
          special_other.foreground = colors.base08;
          special_other.background = colors.base00;
          attribute.foreground = colors.base0A;
          attribute.background = colors.base00;
        };
        size = {
          major.foreground = colors.base05;
          major.background = colors.base00;
          minor.foreground = colors.base05;
          minor.background = colors.base00;
          number_byte.foreground = colors.base05;
          number_byte.background = colors.base00;
          number_kilo.foreground = colors.base05;
          number_kilo.background = colors.base00;
          number_mega.foreground = colors.base05;
          number_mega.background = colors.base00;
          number_giga.foreground = colors.base05;
          number_giga.background = colors.base00;
          number_huge.foreground = colors.base05;
          number_huge.background = colors.base00;
          unit_byte.foreground = colors.base05;
          unit_byte.background = colors.base00;
          unit_kilo.foreground = colors.base05;
          unit_kilo.background = colors.base00;
          unit_mega.foreground = colors.base05;
          unit_mega.background = colors.base00;
          unit_giga.foreground = colors.base05;
          unit_giga.background = colors.base00;
          unit_huge.foreground = colors.base05;
          unit_huge.background = colors.base00;
        };
        users = {
          user_you.foreground = colors.base05;
          user_you.background = colors.base00;
          user_root.foreground = colors.base08;
          user_root.background = colors.base00;
          user_other.foreground = colors.base05;
          user_other.background = colors.base00;
          group_yours.foreground = colors.base05;
          group_yours.background = colors.base00;
          group_other.foreground = colors.base05;
          group_other.background = colors.base00;
          group_root.foreground = colors.base08;
          group_root.background = colors.base00;
        };
        links = {
          normal.foreground = colors.base05;
          normal.background = colors.base00;
          multi_link_file.foreground = colors.base08;
          multi_link_file.background = colors.base00;
        };
        git = {
          new.foreground = colors.base0B;
          new.background = colors.base00;
          modified.foreground = colors.base0A;
          modified.background = colors.base00;
          deleted.foreground = colors.base08;
          deleted.background = colors.base00;
          renamed.foreground = colors.base0D;
          renamed.background = colors.base00;
          ignored.foreground = colors.base04;
          ignored.background = colors.base00;
          conflicted.foreground = colors.base09;
          conflicted.background = colors.base00;
        };
        git_repo = {
          branch_main.foreground = colors.base0D;
          branch_main.background = colors.base00;
          branch_other.foreground = colors.base0E;
          branch_other.background = colors.base00;
          git_clean.foreground = colors.base0B;
          git_clean.background = colors.base00;
          git_dirty.foreground = colors.base09;
          git_dirty.background = colors.base00;
        };
        security_context = {
          none.foreground = colors.base05;
          none.background = colors.base00;
          selinux = {
            colon.foreground = colors.base05;
            colon.background = colors.base00;
            user.foreground = colors.base0D;
            user.background = colors.base00;
            role.foreground = colors.base0E;
            role.background = colors.base00;
            typ.foreground = colors.base0C;
            typ.background = colors.base00;
            range.foreground = colors.base0A;
            range.background = colors.base00;
          };
        };
        file_type = {
          image.foreground = colors.base0C;
          image.background = colors.base00;
          video.foreground = colors.base0D;
          video.background = colors.base00;
          music.foreground = colors.base0E;
          music.background = colors.base00;
          crypto.foreground = colors.base0A;
          crypto.background = colors.base00;
          document.foreground = colors.base0B;
          document.background = colors.base00;
          compressed.foreground = colors.base09;
          compressed.background = colors.base00;
          temp.foreground = colors.base0F;
          temp.background = colors.base00;
          compiled.foreground = colors.base08;
          compiled.background = colors.base00;
          build.foreground = colors.base0A;
          build.background = colors.base00;
          source.foreground = colors.base05;
          source.background = colors.base00;
        };

      };
    };
}
