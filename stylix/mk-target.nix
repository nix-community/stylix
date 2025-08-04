/**
  Provides a consistent target interface, minimizing boilerplate and
  automatically safeguarding declarations related to disabled options.

  # Type

  ```
  mkTarget :: AttrSet -> ModuleBody
  ```

  Where `ModuleBody` is a module that doesn't take any arguments. This allows
  the caller to use module arguments.

  # Examples

  The `modules/«MODULE»/«PLATFORM».nix` modules should use this function as
  follows:

  ```nix
  { mkTarget, lib... }:
  mkTarget {
    unconditionalConfig =
      lib.mkIf complexCondition {
        home.packages = [ pkgs.hello ];
      };

    config = [
      { programs.«name».theme.name = "stylix"; }

      (
        { colors }:
        {
          programs.«name».theme.background = colors.base00;
        }
      )

      (
        { fonts }:
        {
          programs.«name».font.name = fonts.monospace.name;
        }
      )
    ];
  }
  ```

  # Inputs

  `config` (Attribute set)

  : `autoEnable` (Boolean)
    : Whether the target should be automatically enabled by default according
      to the `stylix.autoEnable` option.

      This should be disabled if manual setup is required or if auto-enabling
      causes issues.

      The default (`true`) is inherited from `mkEnableTargetWith`.

    `autoEnableExpr` (String)
    : A string representation of `autoEnable`, for use in documentation.

      Not required if `autoEnable` is a literal `true` or `false`, but **must**
      be used when `autoEnable` is a dynamic expression.

      E.g. `"pkgs.stdenv.hostPlatform.isLinux"`.

    `autoWrapEnableExpr` (Boolean)
    : Whether to automatically wrap `autoEnableExpr` with parenthesis, when it
      contains a potentially problematic infix.

      The default (`true`) is inherited from `mkEnableTargetWith`.

    `config` (List or attribute set or function or path)
    : Configuration functions that are automatically safeguarded when any of
      their arguments is disabled. The provided `cfg` argument conveniently
      aliases to `config.stylix.targets.${name}`.

      For example, the following configuration is not merged if the stylix
      colors option is null:

      ```nix
      (
        { colors }:
        {
          programs.«name».theme.background = colors.base00;
        }
      )
      ```

      The `cfg` alias can be accessed as follows:

      ```nix
      (
        { cfg }:
        {
          programs.«name».extension.enable = cfg.extension.enable;
        }
      )
      ```

    `enableExample` (Boolean or literal expression)
    : An example to include on the enable option. The default is calculated
      automatically by `mkEnableTargetWith` and depends on `autoEnable` and
      whether an `autoEnableExpr` is used.

    `humanName` (String)
    : The descriptive target name passed to the lib.mkEnableOption function
      when generating the `stylix.targets.${name}.enable` option.

    `imports` (List)
    : The `imports` option forwarded to the Nixpkgs module system.

    `options` (Attribute set)
    : Additional options to be added in the `stylix.targets.${name}` namespace
      along the `stylix.targets.${name}.enable` option.

      For example, an extension guard used in the configuration can be declared
      as follows:
      ```nix
      { extension.enable = lib.mkEnableOption "the bloated dependency"; }
      ```

    `name` (String)
    : The target name used to generate options in the `stylix.targets.${name}`
      namespace.

    `unconditionalConfig` (Attribute set or function or path)
    : This argument mirrors the `config` argument but intentionally lacks
      automatic safeguarding and should only be used for complex configurations
      where `config` is unsuitable.

  # Environment

  The function is provided alongside module arguments in any modules imported
  through `/stylix/autoload.nix`.
*/

# TODO: Ideally, in the future, this function returns an actual module by better
# integrating with the /stylix/autoload.nix logic, allowing the following target
# simplification and preventing access to unguarded module arguments by
# requiring /modules/<MODULE>/<PLATFORM>.nix files to be attribute sets instead
# of modules:
#
#     {
#       unconditionalConfig =
#         { lib, pkgs }:
#         lib.mkIf complexCondition {
#           home.packages = [ pkgs.hello ];
#         };
#
#       config = [
#         { programs.example.theme.name = "stylix"; }
#
#         (
#           { colors }:
#           {
#             programs.example.theme.background = colors.base00;
#           }
#         )
#
#         (
#           { fonts }:
#           {
#             programs.example.font.name = fonts.monospace.name;
#           }
#         )
#       ];
#     }
{ humanName, name }:
let
  humanName' = humanName;
  name' = name;
in
{
  autoEnable ? null,
  autoEnableExpr ? null,
  autoWrapEnableExpr ? null,
  config ? [ ],
  enableExample ? null,
  humanName ? humanName',
  imports ? [ ],
  name ? name',
  options ? { },
  unconditionalConfig ? { },
}@args:
let
  mkTargetConfig = config;

  module =
    { config, lib, ... }:
    let
      cfg = config.stylix.targets.${name};

      getArguments =
        function:
        lib.genAttrs
          (lib.pipe function [
            lib.functionArgs
            builtins.attrNames
          ])
          (
            argument:
            if argument == "cfg" then
              cfg

            else
              (
                config':
                let
                  inherit (cfg.${argument}) override;
                in
                if override == null then
                  config'
                else if builtins.typeOf override != builtins.typeOf config' then
                  throw "stylix: expected `config.stylix.targets.${name}.${argument}.override` to be a ${builtins.typeOf config'}, but got: ${builtins.typeOf override})"
                else if builtins.isAttrs override then
                  lib.recursiveUpdate config' override
                else
                  override
              )
                (
                  if argument == "colors" then
                    config.lib.stylix.colors

                  else
                    config.stylix.${argument} or (throw "stylix: mkTarget expected one of ${
                      lib.concatMapStringsSep ", " (expected: "`${expected}`") (
                        lib.naturalSort (
                          [
                            "cfg"
                            "colors"
                          ]
                          ++ builtins.attrNames config.stylix
                        )
                      )
                    }, but got: ${argument}")
                )
          );

      mkConfig =
        let
          areArgumentsEnabled = lib.flip lib.pipe [
            lib.attrsToList
            (builtins.all (
              { name, value }: value.enable or (value != null) && cfg.${name}.enable or true
            ))
          ];
        in
        safeguard: config':
        let
          arguments = getArguments config';
        in
        if builtins.isFunction config' then
          if safeguard then
            lib.mkIf (areArgumentsEnabled arguments) (config' arguments)
          else
            config' arguments

        else if builtins.isAttrs config' then
          config'

        else if builtins.isPath config' then
          throw "stylix: unexpected unresolved path: ${toString config'}"

        else
          throw "stylix: mkTarget expected a configuration to be a function, an attribute set, or a path, but got ${builtins.typeOf config'}: ${
            lib.generators.toPretty { } config'
          }";

      normalizeConfig =
        config:
        map (lib.fix (
          self: config':
          if builtins.isPath config' then self (import config') else config'
        )) (lib.toList config);

      normalizedConfig = normalizeConfig mkTargetConfig;
    in
    {
      imports =
        lib.singleton {
          options.stylix.targets.${name} =
            lib.genAttrs
              (lib.concatLists (
                map (lib.flip lib.pipe [
                  (
                    config': lib.optionalAttrs (builtins.isFunction config') (getArguments config')
                  )
                  builtins.attrNames
                  (lib.remove "cfg")
                ]) (normalizedConfig ++ normalizeConfig options)
              ))
              (
                argument:
                let
                  config = "`${
                    if argument == "colors" then
                      "config.lib.stylix.colors"
                    else
                      "config.stylix.${argument}"
                  }`";
                in
                {
                  enable = lib.mkEnableOption "${config} for ${humanName}" // {
                    default = true;
                    example = false;
                  };

                  override = lib.mkOption {
                    default = null;

                    description = ''
                      Attribute sets are recursively merged with ${config},
                      while all other non-`null` types override ${config}.
                    '';

                    type = lib.types.anything;
                  };
                }
              );
        }
        ++ imports
        ++ lib.singleton { options.stylix.targets.${name} = mkConfig false options; };

      options.stylix.targets.${name}.enable =
        let
          enableArgs =
            {
              name = humanName;
            }
            // lib.optionalAttrs (args ? autoEnable) { inherit autoEnable; }
            // lib.optionalAttrs (args ? autoEnableExpr) { inherit autoEnableExpr; }
            // lib.optionalAttrs (args ? autoWrapEnableExpr) {
              autoWrapExpr = autoWrapEnableExpr;
            }
            // lib.optionalAttrs (args ? enableExample) { example = enableExample; };
        in
        config.lib.stylix.mkEnableTargetWith enableArgs;

      config = lib.mkIf (config.stylix.enable && cfg.enable) (
        lib.mkMerge (
          lib.singleton (mkConfig false unconditionalConfig)
          ++ map (mkConfig true) normalizedConfig
        )
      );
    };
in
{
  imports = [ module ];
}
