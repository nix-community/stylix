mkTarget:
{ lib, ... }:
mkTarget {
  name = "vencord";
  humanName = "Vencord";

  options = {
    themeBody = lib.mkOption {
      type = lib.types.lines;
      default = "";
      internal = true;
    };
    extraCss = lib.mkOption {
      description = "Extra CSS to added to Vencord's theme";
      type = lib.types.lines;
      default = "";
    };
  };

  config = (import ./common/theme-elements.nix "vencord") ++ [
    (
      { cfg }:
      lib.mkIf
        (cfg.themeBody != (import ./common/theme-header.nix) || cfg.extraCss != "")
        {
          xdg.configFile."Vencord/themes/stylix.theme.css".text =
            cfg.themeBody + cfg.extraCss;
        }
    )
  ];
}
