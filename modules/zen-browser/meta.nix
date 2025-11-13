{ lib, ... }:
{
  name = "Zen Browser";
  homepage = "https://zen-browser.app";
  maintainers = [ lib.maintainers.MrSom3body ];
  description = ''
    This module supports the [Zen Browser](https://zen-browser.app).

    > [!IMPORTANT]
    >
    > For any theming to be applied, you need to tell this module which
    > [profiles](https://support.mozilla.org/en-US/kb/profiles-where-firefox-stores-user-data)
    > you're using:
    >
    > ```nix
    > {
    >   programs.zen-browser = {
    >     enable = true;
    >
    >     profiles = {
    >       my-profile = {
    >         # bookmarks, extensions, search engines...
    >       };
    >       my-friends-profile = {
    >         # bookmarks, extensions, search engines...
    >       };
    >     };
    >   };
    >
    >   stylix.targets.zen-browser.profileNames = [ "my-profile" "my-friends-profile" ];
    > }
    > ```
    >
    > This is necessary due to a limitation of the module system: we can either
    > detect the list of profiles, or change their configuration, but we can't do
    > both without infinite recursion.
  '';
}
