{ lib, ... }:
{
  # Declare the arbitrarily named __stub attribute to allow modules to evaluate
  # 'options.services ? «OPTION»'.
  #
  # TODO: Replace 'options.services ? «OPTION»' instances with
  # 'options ? services.«OPTION»' to remove this __stub workaround.
  options.services.__stub = lib.mkSinkUndeclaredOptions { };

  # Some modules use home-manager's `osConfig` arg
  config._module.args.osConfig = null;
}
