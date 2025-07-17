{
  mkTarget,
  lib,
  pkgs,
  config,
  ...
}:
mkTarget {
  name = "gnome";
  humanName = "GNOME and GDM";

  autoEnable =
    config.services.desktopManager.gnome.enable
    || config.services.displayManager.gdm.enable;
  autoEnableExpr = ''
    config.services.desktopManager.gnome.enable
      || config.services.displayManager.gdm.enable
  '';

  generalConfig =
    { colors, inputs }:
    let
      theme = pkgs.callPackage ./theme.nix { inherit colors inputs; };
    in
    {
      nixpkgs.overlays = [
        (_: super: {
          gnome-shell = super.gnome-shell.overrideAttrs (
            oldAttrs:
            lib.optionalAttrs (colors != null && inputs != null) {
              # Themes are usually applied via an extension, but extensions are
              # not available on the login screen. The only way to change the
              # theme there is by replacing the default.
              postFixup =
                (oldAttrs.postFixup or "")
                + ''
                  cp ${theme}/share/gnome-shell/gnome-shell-theme.gresource \
                    $out/share/gnome-shell/gnome-shell-theme.gresource
                '';
              patches = (oldAttrs.patches or [ ]) ++ [
                ./shell_remove_dark_mode.patch
              ];
            }
          );
        })
      ];
    };

  configElements = [
    (
      { image }:
      {
        # As Stylix is controlling the wallpaper, there is no need for this
        # pack of default wallpapers to be installed.
        # If you want to use one, you can set stylix.image to something like
        # "${pkgs.gnome-backgrounds}/path/to/your/preferred/background"
        # which will then download the pack regardless of its exclusion below.
        environment.gnome.excludePackages = [ pkgs.gnome-backgrounds ];
      }
    )
    (
      { cursor }:
      {
        environment.systemPackages = [ cursor.package ];
        programs.dconf.profiles.gdm.databases = [
          {
            lockAll = true;
            settings."org/gnome/desktop/interface" = {
              cursor-theme = config.stylix.cursor.name;
              cursor-size = lib.gvariant.mkInt32 config.stylix.cursor.size;
            };
          }
        ];
      }
    )
  ];
}
