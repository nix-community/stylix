{ mkTarget, ... }:
mkTarget {
  config =
    { colors }:
    {
      programs.lsd.colors = with colors.withHashtag; {
        user = base04;
        group = base04;
        permission = {
          read = base04;
          write = base03;
          exec = base04;
          exec-sticky = base02;
          no-access = base01;
          octal = base03;
          acl = base03;
          context = base03;
        };
        date = {
          hour-old = base03;
          day-old = base04;
          older = base02;
        };
        size = {
          none = base04;
          small = base04;
          medium = base04;
          large = base09;
        };
        inode = {
          valid = base03;
          invalid = base02;
        };
        links = {
          valid = base03;
          invalid = base02;
        };
        tree-edge = base02;
        git-status = {
          default = base03;
          unmodified = base03;
          ignored = base01;
          new-in-index = base0C;
          new-in-workdir = base0C;
          typechange = base0B;
          deleted = base08;
          renamed = base0C;
          modified = base0A;
          conflicted = base09;
        };
      };
    };
}
