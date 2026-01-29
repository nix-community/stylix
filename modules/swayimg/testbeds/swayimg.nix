{
  lib,
  pkgs,
  config,
  ...
}:
let
  image =
    (pkgs.callPackages ../../../stylix/testbed/images.nix { })
    .${config.stylix.polarity};
in
{
  stylix.testbed.ui.command.text = "${lib.getExe pkgs.swayimg} ${image}";
}
