{
  mkTarget,
  pkgs,
  config,
  lib,
  ...
}:
mkTarget {
  name = "gnome";
  humanName = "GNOME";

  autoEnable = pkgs.stdenv.hostPlatform.isLinux;
  autoEnableExpr = "pkgs.stdenv.hostPlatform.isLinux";

  extraOptions.useWallpaper = config.lib.stylix.mkEnableWallpaper "GNOME" true;

  configElements = [
    (
      { cfg, image }:
      {
        dconf.settings."org/gnome/desktop/background" = {
          picture-uri = lib.mkIf cfg.useWallpaper "file://${image}";
          picture-uri-dark = lib.mkIf cfg.useWallpaper "file://${image}";
        };
      }
    )
    (
      { imageScalingMode }:
      {
        dconf.settings."org/gnome/desktop/background".picture-options =
          if imageScalingMode == "fit" then
            "scaled"
          else if imageScalingMode == "fill" then
            "zoom"
          else if imageScalingMode == "stretch" then
            "stretched"
          else if imageScalingMode == "center" then
            "centered"
          # Seemingly no tile support... :(
          else
            "zoom";
      }
    )
    (
      { polarity }:
      {
        # We show the same colours regardless of this setting, and the quick
        # settings tile is removed. The value is still used by Epiphany to
        # request dark mode for websites which support it.
        dconf.settings."org/gnome/desktop/interface".color-scheme =
          if polarity == "dark" then "prefer-dark" else "default";
      }
    )
    (
      { fonts }:
      let
        fontSize = toString fonts.sizes.applications;
        documentFontSize = toString (fonts.sizes.applications - 1);
      in
      {
        dconf.settings."org/gnome/desktop/interface" = {
          # Some GTK apps will use these font settings if they exist.
          # i.e emacs-pgtk.
          font-name = "${fonts.sansSerif.name} ${fontSize}";
          document-font-name = "${fonts.serif.name}  ${documentFontSize}";
          monospace-font-name = "${fonts.monospace.name} ${fontSize}";
        };
      }
    )
    (
      { inputs, colors }:
      let
        extension = pkgs.gnomeExtensions.user-themes;

        activator = pkgs.writeShellApplication {
          name = "stylix-activate-gnome";
          text = ''
            get_exe() {
              for directory in /run/current-system/sw/bin /usr/bin /bin; do
                if [[ -f "$directory/$1" ]]; then
                  printf '%s\n' "$directory/$1"
                  return 0
                fi
              done
              echo "Skipping '$1': command not found"
              return 1
            }

            if gnome_extensions="$(get_exe gnome-extensions)"; then
              extension=${lib.escapeShellArg extension.passthru.extensionUuid}

              case "$1" in
                reload)
                  "$gnome_extensions" disable "$extension"
                  "$gnome_extensions" enable "$extension"
                  ;;
                enable)
                  "$gnome_extensions" enable "$extension"
                  ;;
              esac
            fi
          '';
        };
      in
      {
        home.packages = [ extension ];

        dconf.settings = {
          "org/gnome/shell/extensions/user-theme".name = "Stylix";
          "org/gnome/desktop/background".color-shading-type = "solid";
        };

        xdg = {
          dataFile."themes/Stylix/gnome-shell/gnome-shell.css" = {
            source =
              let
                theme = pkgs.callPackage ./theme.nix { inherit inputs colors; };
              in
              "${theme}/share/gnome-shell/gnome-shell.css";

            # Reload the extension so the new theme is applied immediately.
            # (The extension doesn't watch the file for changes.)
            onChange = "${lib.getExe activator} reload";
          };

          # Enable the extension after logging in.
          configFile."autostart/stylix-activate-gnome.desktop".text = ''
            [Desktop Entry]
            Type=Application
            Exec=${lib.getExe activator} enable
            Name=Stylix: enable User Themes extension for GNOME Shell
          '';
        };
      }
    )
  ];
}
