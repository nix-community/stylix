{ pkgs, ... }:
{
  stylix = {
    enable = true;
    base16Scheme = (import ../color-schemes.nix).catppuccin-macchiato;
    polarity = "dark";
    cursor = {
      name = "Vanilla-DMZ";
      package = pkgs.vanilla-dmz;
      size = 32;
    };
  };
}
