{ lib, ... }:
{
  # Declare the arbitrarily named __stub attribute to allow modules to evaluate
  # 'options.programs ? «OPTION»'.
  #
  # TODO: Replace 'options.programs ? «OPTION»' instances with
  # 'options ? programs.«OPTION»' to remove this __stub workaround.
  options.programs.__stub = lib.mkSinkUndeclaredOptions { };

  # Third-party options are not included in the module eval,
  # so disable checking options definitions have matching declarations
  config._module.check = false;
}
