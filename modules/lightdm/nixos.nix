{ mkTarget, lib, ... }:
mkTarget {
  imports = [
    (lib.mkRenamedOptionModuleWith {
      from = [
        "stylix"
        "targets"
        "lightdm"
        "useWallpaper"
      ];
      sinceRelease = 2605;
      to = [
        "stylix"
        "targets"
        "lightdm"
        "image"
        "enable"
      ];
    })
  ];

  config =
    { image }:
    {
      services.xserver.displayManager.lightdm.background = image;
    };
}
