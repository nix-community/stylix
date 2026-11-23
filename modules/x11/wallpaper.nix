{ lib, pkgs }: {
  mkCommand =
    { image, imageScalingMode }:
    let
      bg-arg =
        if imageScalingMode == "fill" then
          "--bg-fill"
        else if imageScalingMode == "center" then
          "--bg-center"
        else if imageScalingMode == "tile" then
          "--bg-tile"
        else if imageScalingMode == "stretch" then
          "--bg-scale"
        # Fit
        else
          "--bg-max";
    in
    "${lib.getExe pkgs.feh} --no-fehbg ${bg-arg} ${image}";

  renamedOptions = [
    (lib.mkRenamedOptionModuleWith {
      from = [
        "stylix"
        "targets"
        "feh"
        "enable"
      ];
      sinceRelease = 2611;
      to = [
        "stylix"
        "targets"
        "x11"
        "wallpaper"
        "enable"
      ];
    })
    (lib.mkRenamedOptionModuleWith {
      from = [
        "stylix"
        "targets"
        "feh"
        "image"
      ];
      sinceRelease = 2611;
      to = [
        "stylix"
        "targets"
        "x11"
        "image"
      ];
    })
    (lib.mkRenamedOptionModuleWith {
      from = [
        "stylix"
        "targets"
        "feh"
        "imageScalingMode"
      ];
      sinceRelease = 2611;
      to = [
        "stylix"
        "targets"
        "x11"
        "imageScalingMode"
      ];
    })
  ];
}
