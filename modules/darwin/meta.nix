{ lib, ... }:
{
  name = "Darwin";
  homepage = "https://github.com/nix-darwin/nix-darwin";
  description = ''
    Sets the desktop wallpaper via Desktoppr and applies the Stylix accent tint
    on macOS.
  '';
  maintainers = with lib.maintainers; [
    auscyber
    philocalyst
  ];
}
