{ lib, config, ... }:
let
  inherit (lib) types;
in
{
  perSystem.options.ci.nixbot = lib.mkOption {
    type = types.lazyAttrsOf types.raw;
    default = { };
    description = ''
      A set of tests for [nixbot] to run.
      [nixbot]: https://nixbot.nix-community.org
    '';
  };

  flake = {
    # top-level CI option
    #
    # NOTE:
    #   This must be an actual option, NOT a set of options.
    #   Otherwise, flake partitions will not be lazy.
    options.ci = lib.mkOption {
      type = types.lazyAttrsOf (types.lazyAttrsOf types.raw);
      default = { };
      description = ''
        Outputs related to CI.
        Usually defined via the `perSystem.ci` options.
      '';
    };

    # Transpose per-system CI outputs to the top-level
    config.ci.nixbot = lib.mapAttrs (_: sysCfg: sysCfg.ci.nixbot) config.allSystems;
  };
}
