mkTarget:
{ lib, pkgs, ... }:
let
  mkScalingMode =
    imageScalingMode:
    if imageScalingMode == "tile" then
      # desktoppr has no tile mode; fill is the closest supported fallback.
      "fill"
    else
      imageScalingMode;
in
mkTarget {
  name = "desktoppr";
  humanName = "the desktop background using Desktoppr";
  autoEnable = pkgs.stdenv.hostPlatform.isDarwin;
  autoEnableExpr = "pkgs.stdenv.hostPlatform.isDarwin";

  config =
    { image, imageScalingMode }:
    {
      programs.desktoppr = {
        enable = pkgs.stdenv.hostPlatform.isDarwin;
        settings = {
          scale = mkScalingMode imageScalingMode;
          picture = image;
        };
      };

    };
}
