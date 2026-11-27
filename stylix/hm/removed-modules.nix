{ lib, ... }: {
  imports =
    # wayprompt: removed 2026-11-22
    map
      (
        opt:
        lib.mkRemovedOptionModule
          (
            [
              "stylix"
              "targets"
              "wayprompt"
            ]
            ++ opt
          )
          "wayprompt has been removed from nixpkgs and home-manager due to failure to build and lack of upstream maintenance"
      )
      [
        [ "enable" ]
        [
          "colors"
          "enable"
        ]
        [
          "colors"
          "override"
        ]
        [
          "opacity"
          "enable"
        ]
        [
          "opacity"
          "override"
        ]
      ];

}
