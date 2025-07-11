{ lib, ... }:
{
  perSystem =
    { pkgs, config, ... }:
    {
      packages.build-all-maintainers =
        let
          meta = pkgs.callPackage ../../stylix/meta.nix { };
        in
        lib.pipe meta [
          lib.attrsToList
          (map ({ value, ... }: value.maintainers or [ ]))
          builtins.concatLists
          (map (value: {
            name = value.github;
            inherit value;
          }))
          builtins.listToAttrs
          (lib.generators.toPretty { })
          (builtins.toFile "all-maintainers")
        ];

      checks.generated-maintainers = pkgs.testers.testEqualContents {
        assertion = "all-maintainers.nix is up to date";
        expected = config.packages.generate-all-maintainers;
        actual = ../../stylix/generated/all-maintainers.nix;
      };
    };
}
