# NOTE: also used by /modules/zen-browser
{
  name,
  pkgs,
  lib,
}:
[
  (
    { cfg, inputs }:
    let
      inherit (pkgs.stdenv.hostPlatform) system;
      inherit (inputs.nur.legacyPackages.${system}.repos.rycee) firefox-addons;
    in
    lib.mkIf cfg.darkReader.enable {
      programs.${name}.profiles = lib.genAttrs cfg.profileNames (_: {
        extensions.packages = [ firefox-addons.darkreader ];
      });
    }
  )
  (
    { cfg, colors }:
    lib.mkIf cfg.darkReader.enable {
      programs.${name}.profiles = lib.genAttrs cfg.profileNames (_: {
        extensions = {
          settings."addon@darkreader.org".settings.theme = with colors.withHashtag; {
            lightSchemeBackgroundColor = base00;
            darkSchemeBackgroundColor = base00;
            lightSchemeTextColor = base05;
            darkSchemeTextColor = base05;
            selectionColor = base0D;
          };
        };
      });
    }
  )
  (
    { cfg, fonts }:
    lib.mkIf cfg.darkReader.enable {
      programs.${name}.profiles = lib.genAttrs cfg.profileNames (_: {
        extensions = {
          settings."addon@darkreader.org".settings.theme.fontFamily =
            fonts.sansSerif.name;
        };
      });
    }
  )
]
