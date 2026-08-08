{
  mkTarget,
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (config.lib.stylix) mkEnableWallpaper pixel;
in
mkTarget {
  options = {
    useWallpaper = mkEnableWallpaper "GRUB" false;
    theme = {
      main = lib.mkOption {
        type = lib.types.str;
        default = "";
        internal = true;
      };
      progress_bar = lib.mkOption {
        type = lib.types.str;
        default = "";
        internal = true;
      };
      boot_menu = lib.mkOption {
        type = lib.types.str;
        default = "";
        internal = true;
      };
      extraBuildScript = lib.mkOption {
        type = lib.types.str;
        default = "";
        internal = true;
      };
    };
  };

  imports = [
    (lib.mkRenamedOptionModuleWith {
      from = [
        "stylix"
        "targets"
        "grub"
        "useImage"
      ];
      sinceRelease = 2505;
      to = [
        "stylix"
        "targets"
        "grub"
        "useWallpaper"
      ];
    })
  ];

  config = [
    (
      { cfg }:
      lib.mkIf
        (
          cfg.theme.main != ""
          || cfg.theme.progress_bar != ""
          || cfg.theme.boot_menu != ""
        )
        {

          theme =
            pkgs.runCommand "stylix-grub"
              {
                passAsFile = [ "themeTxt" ];
                themeTxt = ''
                  title-text: ""

                  terminal-left: "10%"
                  terminal-top: "20%"
                  terminal-width: "80%"
                  terminal-height: "60%"

                  ${cfg.theme.main}
                ''
                + lib.optionalString (cfg.theme.progress_bar != "") ''
                  + progress_bar {
                    left = 25%
                    top = 80%+20  # 20 pixels below boot menu
                    width = 50%
                    height = 30

                    id = "__timeout__"
                    show_text = true
                    text = "@TIMEOUT_NOTIFICATION_MIDDLE@"
                    ${cfg.theme.progress_bar}
                  }
                ''
                + lib.optionalString (cfg.theme.boot_menu != "") ''
                  + boot_menu {
                    left = 25%
                    top = 20%
                    width = 50%
                    height = 60%
                    menu_pixmap_style = "background_*.png"

                    item_height = 40
                    item_icon_space = 8
                    item_spacing = 0
                    item_padding = 0

                    selected_item_pixmap_style = "selection_*.png"
                    ${cfg.theme.boot_menu}
                  }
                '';
              }
              (
                ''
                  mkdir $out
                  cp $themeTxtPath $out/theme.txt
                ''
                + cfg.theme.extraBuildScript
              );
        }
    )
    (
      { fonts }:
      let
        # Grub requires fonts to be converted to "PFF2 format"
        # This function takes a font { name, package } and produces a .pf2 file
        mkGrubFont =
          font:
          pkgs.runCommand "${font.package.name}.pf2"
            {
              FONTCONFIG_FILE = pkgs.makeFontsConf { fontDirectories = [ font.package ]; };
            }
            ''
              # Use fontconfig to select the correct .ttf or .otf file based on name
              font=$(
                ${lib.getExe' pkgs.fontconfig "fc-match"} \
                ${lib.escapeShellArg font.name} \
                --format=%{file}
              )

              # Convert to .pf2
              ${lib.getExe' pkgs.grub2 "grub-mkfont"} $font --output $out --size ${toString fonts.sizes.applications}
            '';
      in
      {
        boot.loader.grub.font = toString (mkGrubFont fonts.monospace);
        stylix.targets.grub.theme.extraBuildScript =
          "cp ${mkGrubFont fonts.sansSerif} $out/sans_serif.pf2";
      }
    )
    (
      {
        cfg,
        image,
        imageScalingMode,
      }:
      let
        image-scale =
          if imageScalingMode == "fill" then
            "crop"
          else if imageScalingMode == "fit" then
            "fitheight"
          else if imageScalingMode == "center" then
            "padding"
          # Grub doesn't seem to support tile
          else
            "crop";
      in
      {
        stylix.targets.grub.theme = {
          main = ''
            desktop-image: "background.png"
            desktop-image-scale-method: "${image-scale}"
          '';
          extraBuildScript = ''


            ${
              if
                cfg.useWallpaper
              # Make sure the background image is .png by asking to convert it
              then
                ''
                  ${lib.getExe' pkgs.imagemagick "convert"} \
                    ${lib.escapeShellArg image} \
                    "png32:$out/background.png"
                ''
              else
                "cp ${pixel "base00"} $out/background.png"
            }

            cp ${pixel "base01"} $out/background_c.png
            cp ${pixel "base0B"} $out/selection_c.png
          '';
        };
      }
    )
    (
      { colors }:
      {
        stylix.targets.grub.theme = {
          main = ''
            desktop-color: "${colors.withHashtag.base00}"
          '';
        };

        boot.loader.grub = {
          backgroundColor = colors.withHashtag.base00;
          splashImage = pixel "base00";
        };
      }
    )
  ];
}
