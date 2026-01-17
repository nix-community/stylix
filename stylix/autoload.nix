{ lib, pkgs }:
# string -> [ path ]
# List include path for either nixos modules or hm modules
platform:
let
  meta = import ./meta.nix { inherit lib pkgs; };
in
builtins.concatLists (
  lib.mapAttrsToList (
    target: kind:
    let
      file = ../modules/${target}/${platform}.nix;
      module = import file;

      # Detect whether the file's value has an argument named `mkTarget`
      useMkTarget =
        builtins.isFunction module && (builtins.functionArgs module) ? mkTarget;

      # NOTE: `mkTarget` cannot be distributed normally through the module system
      # due to issues of infinite recursion.
      mkTarget = import ./mk-target.nix {
        humanName = meta.${target}.name;
        name = target;
      };
    in
    lib.optional (kind == "directory" && builtins.pathExists file) (
      if useMkTarget then
        { config, ... }@args:
        let
          # Based on `lib.modules.applyModuleArgs`
          #
          # Apply `mkTarget` as a special arg without actually using `specialArgs`,
          # which cannot be defined from within a configuration.
          context =
            name: ''while evaluating the module argument `${name}' in "${toString file}":'';
          extraArgs = lib.pipe module [
            builtins.functionArgs
            (lib.flip removeAttrs [ "mkTarget" ])
            (builtins.mapAttrs (
              name: _:
              builtins.addErrorContext (context name) (
                args.${name} or config._module.args.${name}
              )
            ))
          ];
        in
        {
          key = file;
          _file = file;
          imports = [
            (module (
              args
              // extraArgs
              // {
                inherit mkTarget;
                config = lib.recursiveUpdate config {
                  stylix = throw "stylix: unguarded `config.stylix` accessed while using mkTarget";
                  lib.stylix.colors = throw "stylix: unguarded `config.lib.stylix.colors` accessed while using mkTarget";
                };
              }
            ))
          ];
        }
      else
        file
    )
  ) (builtins.readDir ../modules)
)
