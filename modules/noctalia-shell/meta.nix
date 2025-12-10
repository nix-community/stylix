{ lib, ... }:
{
  name = "Noctalia shell";
  homepage = "https://docs.noctalia.dev";
  maintainers = [ lib.maintainers.rwxae ];
  description = ''
    > [!IMPORTANT]
    >
    > If you previously configured Noctalia using the GUI, enabling this target
    > **will override** your existing settings.
    >
    > You must migrate your current settings from `~/.config/noctalia/settings.json`
    > to Nix using the `programs.noctalia-shell.settings` option.
    >
    > See the [official documentation](https://docs.noctalia.dev/getting-started/nixos/#noctalia-settings)
    > for more information.
  '';
}
