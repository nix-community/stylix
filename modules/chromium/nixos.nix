{ mkTarget, pkgs, ... }:

mkTarget {
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

      updateManifest =
        pkgs.writeText "stylix-chromium-theme-extension-update-manifest"
          /* xml */ ''
            <?xml version="1.0" encoding="UTF-8"?>
            <gupdate xmlns="http://www.google.com/update2/response" protocol="2.0">
              <app appid="${themeExtension.id}">
                <updatecheck codebase="file://${themeExtension}" version="${themeExtension.version}" />
              </app>
            </gupdate>
          '';
    in
    {
      programs.chromium.extensions = [
        "${themeExtension.id};file://${updateManifest}"
      ];
    };
}
