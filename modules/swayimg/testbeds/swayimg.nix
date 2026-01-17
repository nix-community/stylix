{
  lib,
  pkgs,
  config,
  ...
}:
let
  package = pkgs.swayimg;
  image =
    (pkgs.callPackages ../../../stylix/testbed/images.nix { })
    .${config.stylix.polarity};
in
{
  stylix.targets.swayimg.enable = true;

  environment = {
    systemPackages = [ package ];

    loginShellInit = ''
      ${lib.getExe package} ${image}
    '';
  };
}
