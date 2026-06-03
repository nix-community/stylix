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

  configElements =
    { image, imageScalingMode }:
    {
      home.activation.stylixBackground = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        run ${lib.getExe pkgs.desktoppr} ${lib.escapeShellArg image}
        sleep 1
        run ${lib.getExe pkgs.desktoppr} scale ${mkScalingMode imageScalingMode}
      '';
    };
}
