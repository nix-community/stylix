mkTarget:
{ lib, ... }:
mkTarget {
  name = "vesktop";
  humanName = "Vesktop";

  options.themeBody = lib.mkOption {
    type = lib.types.lines;
    default = "";
    internal = true;
  };

  config = (import ./common/theme-elements.nix "vesktop") ++ [
    (
      { cfg }:
      lib.mkIf (cfg.themeBody != (import ./common/theme-header.nix)) {
        programs.vesktop.vencord = {
          themes.stylix = cfg.themeBody;
          settings.enabledThemes = [ "stylix.css" ];
        };
      }
    )
  ];

  imports = lib.singleton (
    lib.mkRemovedOptionModule [ "stylix" "targets" "vesktop" "extraCss" ]
      "CSS can be added to by declaring 'programs.vesktop.vencord.themes.stylix = lib.mkAfter \"YOUR EXTRA CSS\";"
  );
}
