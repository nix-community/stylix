{ lib, ... }:
{
  name = "Steam";
  homepage = "https://store.steampowered.com";
  maintainers = [ lib.maintainers.bricked ];
  description = ''
    > [!IMPORTANT]

    > You need to run the AdwSteamGTK application to apply this theme.
    > Requires `programs.dconf` to be enabled in the NixOS configuration.
  '';
}
