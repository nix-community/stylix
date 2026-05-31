# manually applied args
{
  mkTarget,
  name,
  humanName,
}:
# module args
{
  lib,
  pkgs,
  config,
  ...
}:
mkTarget {
  inherit humanName name;

  options.profileNames = lib.mkOption {
    description = "The ${humanName} profile names to apply styling on.";
    type = lib.types.listOf lib.types.str;
    default = [ "default" ];
  };

  config = [
    (
      { cfg }:
      {
        warnings =
          lib.optional (config.programs.${name}.enable && cfg.profileNames == [ ])
            "stylix: ${name}: `config.stylix.targets.${name}.profileNames` is empty. No theming will be applied. Add a profile or disable this warning by setting `stylix.targets.${name}.enable = false`.";
      }
    )
    (
      { cfg, colors }:
      {
        programs.${name}.profiles = lib.genAttrs cfg.profileNames (_: {
          extensions = lib.singleton (
            pkgs.runCommandLocal "stylix-vscode"
              {
                vscodeExtUniqueId = "stylix.stylix";
                vscodeExtPublisher = "stylix";
                version = "0.0.0";
                theme = builtins.toJSON (import ./templates/theme.nix colors);
                passAsFile = [ "theme" ];
              }
              ''
                mkdir -p "$out/share/vscode/extensions/$vscodeExtUniqueId/themes"
                ln -s ${./package.json} "$out/share/vscode/extensions/$vscodeExtUniqueId/package.json"
                cp "$themePath" "$out/share/vscode/extensions/$vscodeExtUniqueId/themes/stylix.json"
              ''
          );
        });
      }
    )
    (
      { cfg, fonts }:
      {
        programs.${name}.profiles = lib.genAttrs cfg.profileNames (_: {
          userSettings = import ./templates/settings.nix fonts;
        });
      }
    )
  ];
}
