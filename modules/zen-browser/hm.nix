{
  mkTarget,
  lib,
  config,
  ...
}:
{
  imports = [ ./deprecated.nix ];

  options.programs.zen-browser.profiles = lib.mkOption {
    type = lib.types.attrsOf (
      lib.types.submodule (
        lib.modules.importApply ./pre-profile.nix {
          inherit mkTarget;
          stylixLib = config.lib.stylix;
        }
      )
    );
  };
}
