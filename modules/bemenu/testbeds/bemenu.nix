{ config, lib, ... }:
let
  homeConfig = config.home-manager.users.guest;
  expectedSize = homeConfig.stylix.fonts.sizes.popups.pt;
in
{
  stylix = {
    fonts.sizes.popups.px = 15.5;

    testbed.ui = {
      graphicalEnvironment = "hyprland";
      command.text = "bemenu-run";
    };
  };

  assertions = [
    {
      assertion = expectedSize == 11.625;
      message = "The Bemenu testbed must exercise a fractional point size.";
    }
    {
      assertion =
        homeConfig.stylix.targets.bemenu.fontSize == expectedSize
        &&
          homeConfig.programs.bemenu.settings.fn
          == "${homeConfig.stylix.fonts.sansSerif.name} ${toString expectedSize}";
      message = "Stylix must preserve Bemenu's fractional Pango point size.";
    }
  ];

  home-manager.sharedModules = lib.singleton { programs.bemenu.enable = true; };
}
