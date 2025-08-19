# Test a complete Stylix configuration with a dark theme, image, and all options
# set to non-default values.
{
  config,
  lib,
  pkgs,
  ...
}:
{
  stylix = {
    enable = true;

    # TODO: Declare different dark and light themes after resolving [1].
    #
    # [1]: https://github.com/nix-community/stylix/issues/1855
    icons = {
      dark = "Adwaita";
      enable = true;
      light = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    overlays.enable = true;
    polarity = "dark";

    override =
      {
        author = "Stylix";
        scheme = "Catppuccin Macchiato and Mocha";
        slug = "catppuccin-macchiato-and-mocha";
      }
      // lib.importJSON (
        pkgs.runCommand "catppuccin-macchiato-and-mocha.json"
          {
            nativeBuildInputs = [ pkgs.yq-go ];
            src = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
          }
          ''
            yq \
              --output-format json \
              '
                .palette |
                with_entries(select(.key | test("^base0(1|3|5|7|9|B|D|F)$")))
              ' \
              <"$src" \
              >"$out"
          ''
      );

    # TODO: Explicitly enable the color functionality with 'stylix.colors.enable
    # = true;' once this option is implemented.
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";

    cursor = {
      name = "Bibata-Modern-Amber";
      package = pkgs.bibata-cursors;
      size = 25;
    };

    fonts = {
      # TODO: Since this declaration is the default stylix.fonts.emoji value,
      # the default value or this declaration should be changed.
      emoji = {
        name = "Noto Color Emoji";
        package = pkgs.noto-fonts-color-emoji;
      };

      monospace = {
        name = "Fira Code";
        package = pkgs.fira-code;
      };

      sansSerif = {
        name = "Noto Sans";
        package = pkgs.noto-fonts;
      };

      serif = {
        name = "Noto Serif";
        package = pkgs.noto-fonts;
      };

      sizes = lib.genAttrs (builtins.attrNames config.stylix.fonts.sizes) (_: 14);
    };

    # Test path containing special characters.
    image =
      let
        file = "${
          lib.pipe "-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz" [
            lib.stringToCharacters
            (builtins.concatStringsSep " ")
          ]
        }.jpg";
      in
      "${
        pkgs.runCommandLocal "image-path-containing-special-characters"
          {
            src = pkgs.fetchurl {
              hash = "sha256-Dm/0nKiTFOzNtSiARnVg7zM0J1o+EuIdUQ3OAuasM58=";
              name = "image.jpg";
              url = "https://unsplash.com/photos/ZqLeQDjY6fY/download";
            };
          }
          ''
            mkdir "$out"
            cp "$src" "$out"/${lib.escapeShellArg file}
          ''
      }/${file}";

    opacity = lib.genAttrs (builtins.attrNames config.stylix.opacity) (_: 0.8);
  };
}
