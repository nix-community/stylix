{ mkTarget, ... }:
mkTarget {
  requiredOptions = [
    [
      "programs"
      "tmux"
      "extraConfig"
    ]
  ];

  config = { colors, inputs }: {
    programs.tmux.extraConfig = ''
      source-file ${
        colors {
          templateRepo = inputs.tinted-tmux;
          target = "base16";
        }
      }
    '';
  };
}
