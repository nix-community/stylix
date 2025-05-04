{ lib, ... }:
{
  options = {
    # Declare the arbitrarily named __stub attribute to allow modules to evaluate
    # 'options.programs ? «OPTION»'.
    #
    # TODO: Replace 'options.programs ? «OPTION»' instances with
    # 'options ? programs.«OPTION»' to remove this __stub workaround.
    programs.__stub = lib.mkSinkUndeclaredOptions { };

    # The config.lib option, as found in NixOS and home-manager.
    # Many option declarations depend on `config.lib.stylix`.
    lib = lib.mkOption {
      type = lib.types.attrsOf lib.types.attrs;
      description = ''
        This option allows modules to define helper functions, constants, etc.
      '';
      default = { };
      visible = false;
    };
  };

  # Third-party options are not included in the module eval,
  # so disable checking options definitions have matching declarations
  config._module.check = false;
}
