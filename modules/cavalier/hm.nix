{ mkTarget, lib, ... }:
mkTarget {
  config =
    { colors }:
    {
      programs.cavalier.settings.general = {
        ColorProfiles = lib.singleton {
          Name = "Stylix";
          FgColors = [ colors.base05 ];
          BgColors = [ colors.base00 ];
        };
        ActiveProfile = 0;
      };
    };
}
