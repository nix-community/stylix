{ mkTarget, ... }:
mkTarget {
  config =
    { colors }:
    {
      programs.fish.interactiveShellInit =
        let
          theme = colors {
            template = ./theme.mustache;
            extension = ".fish";
          };
        in
        ''
          source ${theme}

          # See https://github.com/tomyun/base16-fish/issues/7 for why this condition exists
          if test -z $TMUX
            base16-${colors.slug}
          end
        '';
    };
}
