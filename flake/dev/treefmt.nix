{ inputs, ... }:
{
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem.treefmt = {
    projectRootFile = "flake.nix";

    programs = {
      # keep-sorted start block=yes newline_separated=no
      biome = {
        enable = true;
        settings.formatter = {
          indentStyle = "space";
          indentWidth = 2;
          lineWidth = 80;
        };
        includes = [
          "*.css"
          "*.js"
          "*.json"
        ];
        excludes = [
          # Contains custom syntax that biome can't handle
          "modules/swaync/base.css"
        ];
      };
      keep-sorted.enable = true;
      nixfmt = {
        enable = true;
        width = 80;
      };
      ruff-format = {
        enable = true;
        lineLength = 80;
      };
      shfmt.enable = true;
      stylish-haskell.enable = true;
      # keep-sorted end
    };
  };
}
