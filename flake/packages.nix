{ inputs, ... }:
{
  perSystem =
    { pkgs, config, ... }:
    {
      # Make 'nix run .#doc' serve the documentation site
      apps.doc.program = config.packages.serve-docs;

      packages = {
        doc = pkgs.callPackage ../doc {
          inherit (inputs) self;
        };
        serve-docs = pkgs.callPackage ../doc/server.nix {
          inherit (config.packages) doc;
        };
        palette-generator = pkgs.callPackage ../palette-generator { };
      };
    };
}
