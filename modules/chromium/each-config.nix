# target args
{
  mkTarget,
  name,
  humanName,
  ...
}:
# module args
{ pkgs, ... }:
mkTarget {
  inherit name humanName;

  config =
    { colors }:
    let
      crx3rs = pkgs.callPackage ./crx3rs.nix { };

      manifest = colors {
        template = ../firefox/manifest.json.mustache;
        extension = ".json";
      };

      themeExtension = pkgs.callPackage ./themeExtension.nix {
        inherit manifest crx3rs;
      };
    in
    {
      programs.${name}.extensions = [
        {
          inherit (themeExtension) id version;
          crxPath = themeExtension;
        }
      ];
    };
}
