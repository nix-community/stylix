{ lib, ... }:
{
  name = "Hyprland";
  homepage = "https://github.com/hyprwm/Hyprland";
  maintainers = with lib.maintainers; [
    noahbiewesch
    skoove
  ];
}
