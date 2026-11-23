{ mkTarget, lib, ... }:
mkTarget {
  requiredOptions = [
    [
      "services"
      "xserver"
      "displayManager"
      "lightdm"
      "background"
    ]
  ];

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

  config = { image }: {
    services.xserver.displayManager.lightdm.background = image;
  };
}
