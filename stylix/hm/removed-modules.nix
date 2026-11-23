{ lib, ... }:
{
  imports = [
    # added 2026-11-22
    (lib.mkRemovedOptionModule [ "stylix" "targets" "wayprompt" "enable" ]
      "The wayprompt target was removed because nixpkgs dropped the wayprompt package, so 'programs.wayprompt' no longer has any effect. Remove this option from your configuration."
    )
  ];
}
