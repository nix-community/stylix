{ lib, ... }:
{
  name = "Steam";
  homepage = "https://store.steampowered.com";
  maintainers = [ lib.maintainers.bricked ];
  description = ''
    > [!IMPORTANT]
    > You need to run the AdwSteamGTK application to apply this theme.
  '';
}
