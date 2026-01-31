{ lib, ... }:
{
  name = "Steam";
  homepage = "https://store.steampowered.com";
  maintainers = [ lib.maintainers.bricked ];
  description = ''
    > [!IMPORTANT]
    >
    > This target will have no effect unless the AdwSteamGTK application is run
    > to apply this theme.
  '';
}
