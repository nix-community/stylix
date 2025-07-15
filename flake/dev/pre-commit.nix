{ inputs, ... }:
{
  imports = [
    inputs.git-hooks.flakeModule
  ];

  perSystem =
    { config, ... }:
    {
      pre-commit = {
        check.enable = true;

        settings.hooks = {
          # keep-sorted start block=yes
          deadnix = {
            enable = true;
            settings.noLambdaPatternNames = true;
          };
          editorconfig-checker.enable = true;
          hlint.enable = true;
          statix.enable = true;
          treefmt = {
            enable = true;
            package = config.formatter;
          };
          typos = {
            enable = true;
            settings.configuration = ''
              [default.extend-identifiers]
              MrSom3body="MrSom3body"
            '';
          };
          yamllint.enable = true;
          # keep-sorted end
        };
      };
    };
}
