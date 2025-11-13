name: [
  {
    stylix.targets.${name}.themeBody = import ./theme-header.nix;
  }
  (
    { fonts }:
    {
      stylix.targets.${name}.themeBody = import ./font-theme.nix fonts;
    }
  )
  (
    { colors }:
    {
      stylix.targets.${name}.themeBody = import ./color-theme.nix colors;
    }
  )
]
