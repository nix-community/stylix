# Test Stylix's modularity with a light theme, no image, and specific features
# disabled.
{
  config,
  lib,
  pkgs,
  ...
}:
{
  stylix = {
    enable = true;

    icons = {
      dark = "Adwaita";
      enable = true;
      package = pkgs.adwaita-icon-theme;
    };

    overlays.enable = true;
    polarity = "light";

    # TODO: Explicitly disable the color functionality with
    # 'stylix.colors.enable = false;' once this option is implemented.

    # TODO: Properly disable the cursor functionality by replacing the
    # stylix.cursor declaration with 'stylix.cursor.enable = false;' once this
    # option is implemented.
    cursor = null;

    # TODO: Disable the font functionality with 'stylix.fonts.enable = false;'
    # once this option is implemented.

    image = pkgs.fetchurl {
      hash = "sha256-S0MumuBGJulUekoGI2oZfUa/50Jw0ZzkqDDu1nRkFUA=";
      name = "image.jpg";
      url = "https://unsplash.com/photos/hwLAI5lRhdM/download";
    };

    opacity = lib.genAttrs (builtins.attrNames config.stylix.opacity) (_: 0.8);
  };
}
