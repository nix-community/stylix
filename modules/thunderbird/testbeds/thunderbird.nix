{ lib, ... }:
let
  profileName = "stylix";
in
{
  stylix.testbed.ui.command.text = "thunderbird";

  home-manager.sharedModules = lib.singleton {
    programs.thunderbird = {
      enable = true;

      profiles.${profileName} = {
        isDefault = true;

        settings = {
          # Without this, Thunderbird opens the account setup wizard.
          "mail.provider.suppress_dialog_on_startup" = true;

          # Skip the "make Thunderbird the default client" prompt.
          "mail.shell.checkDefaultClient" = false;
        };
      };
    };

    stylix.targets.thunderbird.profileNames = [ profileName ];
  };
}
