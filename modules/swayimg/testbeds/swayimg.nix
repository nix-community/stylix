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

  stylix.testbed.ui.command = {
    text = "${lib.getExe package} ${image}";
    inherit package;
  };
}
