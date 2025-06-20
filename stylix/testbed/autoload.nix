{
  pkgs,
  lib,
  testbedFieldSeparator ? ":",
}:
let
  isEnabled = pkgs.callPackage ./is-enabled.nix { };

  # Describes all testbed modules loaded from the modules directory.
  # A list of attrsets, each containing: { module, path, name }
  testbeds = lib.pipe ../../modules [
    builtins.readDir
    builtins.attrNames
    (builtins.concatMap (
      module:
      let
        testbeds = ../../modules/${module}/testbeds;
        files = lib.optionalAttrs (builtins.pathExists testbeds) (
          builtins.readDir testbeds
        );
      in
      lib.mapAttrsToList (
        testbed: type:
        let
          path = testbeds + "/${testbed}";
          pathStr = toString path;
        in
        if type != "regular" then
          throw "${pathStr} must be regular: ${type}"

        else if !lib.hasSuffix ".nix" testbed then
          throw "testbed must be a Nix file: ${pathStr}"

        else if testbed == ".nix" then
          throw "testbed must have a name: ${pathStr}"

        else
          {
            inherit module path;
            name = lib.removeSuffix ".nix" testbed;
          }
      ) files
    ))
  ];

  # Import all the testbed themes
  themes = lib.pipe ./themes [
    builtins.readDir
    (lib.filterAttrs (name: _: lib.strings.hasSuffix ".nix" name))
    (builtins.mapAttrs (
      name: type:
      lib.throwIfNot (type == "regular")
        "Unexpected filetype in testbed themes: ${toString ./themes/${name}} is a ${type}."
        ./themes/${name}
    ))
    (lib.mapAttrs' (name: lib.nameValuePair (lib.strings.removeSuffix ".nix" name)))
  ];

  # Construct a NixOS module for the testbed+theme combination.
  #
  # If the testbed module is enabled, returns an attrset containing it:
  # { «name» = «modele»; }
  #
  # Returns an empty attrset if the testbed module is not enabled.
  # { }
  makeTestbedModule =
    testbed: themeName: themeModule:
    let
      joinFields = builtins.concatStringsSep testbedFieldSeparator;

      fields =
        map
          (
            field:
            lib.throwIf (lib.hasInfix testbedFieldSeparator field)
              "testbed field must not contain the '${testbedFieldSeparator}' testbed field separator: ${field}"
              field
          )
          [
            "testbed"
            testbed.name
            themeName
          ];

      name = joinFields fields;
    in
    lib.optionalAttrs (isEnabled testbed.path) {
      ${name} = {
        # Unique key for de-duplication
        key = joinFields [
          (toString ./.)
          name
        ];

        # Location displayed in errors
        _file = name;

        # Avoid accidental imports, e.g. in submodules or home-manager
        _class = "nixos";

        imports = [
          testbed.path
          themeModule
        ];

        config.system.name = name;
      };
    };

  # Generates a copy of each testbed for each of the imported themes.
  # I.e. a testbeds*themes matrix
  makeTestbeds = testbed: lib.mapAttrsToList (makeTestbedModule testbed) themes;
in
# Testbeds are merged using lib.attrsets.unionOfDisjoint to throw an error if
# any name collides.
builtins.foldl' lib.attrsets.unionOfDisjoint { } (
  builtins.concatMap makeTestbeds testbeds
)
