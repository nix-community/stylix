{ inputs, ... }:
{
  imports = [ inputs.git-hooks.flakeModule ];

  perSystem =
    { config, ... }:
    {
      ci.buildbot = { inherit (config.checks) pre-commit; };

      pre-commit = {
        check.enable = true;

        settings.hooks = {
          # keep-sorted start block=yes
          all-maintainers = {
            enable = true;
            entry = config.apps.all-maintainers.program;
            files = "^(${
              builtins.concatStringsSep "|" [
                ''flake\.lock''
                ''generated\/all-maintainers.nix''
                ''modules\/.*\/meta\.nix''
                ''stylix\/maintainers\.nix''
              ]
            })$";
          };
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
            settings.config.default.extend-identifiers.MrSom3body = "MrSom3body";
          };
          yamllint.enable = true;
          # keep-sorted end
        };
      };
    };
}
