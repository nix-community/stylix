{ lib, ... }: {
  name = "Thunderbird";
  homepage = "https://www.thunderbird.net";

  maintainers = [ lib.maintainers.nsrkn2n ];

  description = ''
    This module themes [Thunderbird](https://www.thunderbird.net) through its
    [userChrome.css and userContent.css](https://kb.mozillazine.org/UserChrome.css)
    support, overriding the CSS custom properties of Thunderbird's internal
    stylesheets.

    > [!IMPORTANT]
    >
    > For any theming to be applied, you need to tell this module which
    > [profiles](https://support.mozilla.org/en-US/kb/profiles-where-thunderbird-stores-user-data)
    > you're using:
    >
    > ```nix
    > {
    >   programs.thunderbird = {
    >     enable = true;
    >
    >     profiles = {
    >       my-profile = {
    >         # accounts, calendars, ...
    >       };
    >     };
    >   };
    >
    >   stylix.targets.thunderbird.profileNames = [ "my-profile" ];
    > }
    > ```
    >
    > This is necessary due to a limitation of the module system: we can either
    > detect the list of profiles, or change their configuration, but we can't do
    > both without infinite recursion.
  '';
}
