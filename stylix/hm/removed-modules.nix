{ lib, ... }: {
  imports = [
    # wayprompt: removed 2026-11-22
    (lib.mkRemovedOptionModule [ "stylix" "targets" "wayprompt" ]
      "wayprompt has been removed from nixpkgs and home-manager due to failure to build and lack of upstream maintenance"
    )
    # cavalier: removed 2026-11-23
    (lib.mkRemovedOptionModule [
      "stylix"
      "targets"
      "cavalier"
    ] "cavalier has been removed from nixpkgs due to lack of upstream maintenance")
  ];
}
