{
  mkTarget,
  config,
  lib,
  pkgs,
  ...
}:

mkTarget {
  name = "darwin";
  humanName = "Darwin";

  configElements = [
    (
      {
        image,
        pkgs,
      }:
      {
        home.activation = {
          stylixBackground = ''
            run ${pkgs.callPackage ../../stylix/darwin/desktoppr.nix { }}/bin/desktoppr all ${image}
          '';
        };
      }
    )
    (
      {
        colors,
      }:

      {

        targets.darwin.defaults."Apple Global Domain" = {
          AppleIconAppearanceCustomTintColor = builtins.readFile "${
            pkgs.runCommand "color" { } ''
              full=$((16#${colors.base00}))
              red=$((($full >> 16) & 0xff))
              red=$(echo "scale=10; $red.0 / 255.0 " | bc |awk '{printf "%f", $0}')
              green=$((($full >> 8) & 0xff))
              green=$(echo "scale=10; $green.0 / 255.0  " | bc | awk '{printf "%f", $0}')
              blue=$(($full & 0xff))
              blue=$(echo "scale=10; $blue.0 / 255.0 " | bc | awk '{printf "%f", $0}')
              echo "$red $green $blue 1.0" > $out
            ''

          }";
        };
      }
    )
  ];

}
