# Test Stylix being enabled with all its features disabled.
{
  config,
  lib,
  pkgs,
  ...
}:
{
  stylix = {
    enable = true;
    icons.enable = false;
    overlays.enable = false;

    # TODO: Disable the color functionality by replacing the mandatory
    # stylix.base16Scheme declaration with 'stylix.colors.enable = false;' once
    # this option is implemented.
    base16Scheme = "${pkgs.base16-schemes}/share/themes/mellow-purple.yaml";

    # TODO: Properly disable the cursor functionality by replacing the
    # stylix.cursor declaration with 'stylix.cursor.enable = false;' once this
    # option is implemented.
    cursor = null;

    # TODO: Disable the font functionality with 'stylix.fonts.enable = false;'
    # once this option is implemented.

    # TODO: Properly disable the image functionality by replacing the
    # stylix.image declaration with 'stylix.image.enable = false;' once this
    # option is implemented. The stylix.image.enable namespace is subject to
    # change.
    image = null;

    # TODO: Properly disable the opacity functionality by replacing the
    # stylix.opacity declaration with 'stylix.opacity.enable = false;' once this
    # option is implemented.
    opacity = lib.genAttrs (builtins.attrNames config.stylix.opacity) (_: 1.0);
  };
}
