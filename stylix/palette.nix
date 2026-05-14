{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.stylix;

  base = {
    inherit (cfg) polarity;
    palette = { inherit (cfg.palette.manual) base16 base24 semantic; };
  };

  # Converts a scheme (path/YAML/attrs) into normalized JSON.
  # Used for manual palette inputs.
  resolveScheme =
    scheme:
    if scheme == null then
      null
    else if lib.isAttrs scheme then
      scheme
    else
      lib.importJSON (
        pkgs.runCommand "scheme.json" { nativeBuildInputs = [ pkgs.yq-go ]; } ''
          yq -o=json < ${scheme} > $out
        ''
      );

  withGenerated = lib.recursiveUpdate base {
    palette = {
      base16 =
        if cfg.palette.generators.base16 != null then
          lib.importJSON (cfg.palette.generators.base16 cfg.polarity cfg.image)
        else
          resolveScheme base.palette.base16;
      base24 =
        if cfg.palette.generators.base24 != null then
          lib.importJSON (cfg.palette.generators.base24 cfg.polarity cfg.image)
        else
          resolveScheme base.palette.base24;
      semantic =
        if cfg.palette.generators.semantic != null then
          lib.importJSON (cfg.palette.generators.semantic cfg.polarity cfg.image)
        else
          resolveScheme base.palette.semantic;
    };
  };

  mapped = cfg.palette.mappingFunction withGenerated;
in
{
  /*
    Stylix palette pipeline:

      1. Input sources:
        - manual.{base16, base24, semantic}
        - generators.{...}

      2. Resolution:
        - generator output OR manual scheme
        → normalized into JSON

      3. mappingFunction:
        - transforms palette set
        - can derive missing formats (e.g. semantic -> base16)

      4. override:
        - final tweaks before consumption

      5. Consumption (this will later be changed to allow multiple schemes to be consumed):
        - base16 ->→ config.lib.stylix.colors
        - templates (JSON / HTML)
  */
  imports = lib.singleton (
    lib.mkRenamedOptionModule
      [ "stylix" "base16Scheme" ]
      [ "stylix" "palette" "manual" "base16" ]
  );

  options.stylix = {
    lib = {
      mappings = lib.mkOption {
        type = lib.types.attrs;
        readOnly = true;
        internal = true;
        description = "Stylix-provided palette mapping functions.";
        default = import ./mappings.nix { };
      };

      generators = lib.mkOption {
        type = lib.types.attrs;
        readOnly = true;
        internal = true;
        description = "Stylix-provided palette generator functions.";
        default = import ./generators.nix { inherit pkgs lib config; };
      };
    };

    polarity = lib.mkOption {
      type = lib.types.enum [
        "light"
        "dark"
      ];
      default = "light";
      description = ''
        Whether to apply the dark or light theme.
      '';
    };

    image = lib.mkOption {
      # Ensure the path is copied to the store
      type = with lib.types; nullOr (coercedTo path (src: "${src}") pathInStore);
      description = ''
        Wallpaper image.

        This is set as the background of your desktop environment, if possible,
        and used to generate a colour scheme if you don't set one manually.
      '';
      default = null;
    };

    imageScalingMode = lib.mkOption {
      type = lib.types.enum [
        "stretch"
        "fill"
        "fit"
        "center"
        "tile"
      ];
      default = "fill";
      description = ''
        Scaling mode for the wallpaper image.

        `stretch`
        : Stretch the image to cover the screen.

        `fill`
        : Scale the image to fill the screen, potentially cropping it.

        `fit`
        : Scale the image to fit the screen without being cropped.

        `center`
        : Center the image without resizing it.

        `tile`
        : Tile the image to cover the screen.
      '';
    };

    generated = {
      fileTree = lib.mkOption {
        type = lib.types.raw;
        description = "The files storing the palettes in json and html.";
        readOnly = true;
        internal = true;
      };
    };

    palette = {
      generators = {
        base16 = lib.mkOption {
          type = with lib.types; nullOr (functionTo (functionTo package));
          default = null;
          description = ''
            A function taking polarity and image path, returning a derivation
            that produces a base16 palette JSON file.

            Stylix provides built-in generators such as
            `config.stylix.lib.generators.base16.tinty`.
          '';
          example = lib.literalExpression ''
            polarity: image: pkgs.runCommand "palette.json" {} ""
          '';
        };

        base24 = lib.mkOption {
          type = with lib.types; nullOr (functionTo (functionTo package));
          default = null;
          description = ''
            A function taking polarity and image path, returning a derivation
            that produces a base24 palette JSON file.

            Stylix provides built-in generators such as
            `config.stylix.lib.generators.base24.tinty`.
          '';
          example = lib.literalExpression ''
            polarity: image: pkgs.runCommand "palette.json" {} ""
          '';
        };

        semantic = lib.mkOption {
          type = with lib.types; nullOr (functionTo (functionTo package));
          default = null;
          description = ''
            A function taking polarity and image path, returning a derivation
            that produces a semantic palette JSON file.

            The semantic scheme uses material design role names as produced
            natively by matugen, preserving more information than a base16
            conversion would.

            Stylix provides built-in generators such as
            `config.stylix.lib.generators.semantic.matugen`.
          '';
          example = lib.literalExpression ''
            polarity: image: pkgs.runCommand "palette.json" {} ""
          '';
        };
      };
      mappingFunction = lib.mkOption {
        type = with lib.types; functionTo attrs;
        default = lib.id;
        description = ''
              A function taking an attribute set of the form:

          ```nix
              {
                polarity = "dark" | "light";
                palette = {
                  base16 = { base00 = "..."; ... } | null;
                  base24 = { ... } | null;
                  semantic = { ... } | null;
                };
              }
          ```

              and returning an attribute set of the same shape with mapped values.

              This function runs *after palette generation/manual resolution* and is the
              primary mechanism for converting between palette formats (e.g. semantic -> base16).

              Defaults to the identity function. Can be constructed by chaining
              stylix-provided mapping functions such as
              `stylix.lib.mappings.semantic2base16`,
              `stylix.lib.mappings.base162base24`, etc:

          ```nix
              mappingFunction = lib.pipe [
                stylix.lib.mappings.semantic2base16
                stylix.lib.mappings.base162base24
              ];
          ```
        '';
        example = lib.literalExpression ''
          { polarity, palette }: {
            inherit polarity;
            palette = palette // {
              base16 = palette.base16 // { base00 = "000000"; };
            };
          }
        '';
      };
      manual = {
        base16 = lib.mkOption {
          description = ''
            A scheme following the base16 standard.

            This can be a path to a file, a string of YAML, or an attribute set.

            Used only if the corresponding generator is not set.

            The value is normalized to JSON before being passed to `mappingFunction`.
          '';
          type =
            with lib.types;
            nullOr (oneOf [
              path
              lines
              attrs
            ]);
          default = null;
          defaultText = lib.literalMD "";
        };
        base24 = lib.mkOption {
          description = ''
            A scheme following the base24 standard.

            This can be a path to a file, a string of YAML, or an attribute set.

            Used only if the corresponding generator is not set.

            The value is normalized to JSON before being passed to `mappingFunction`.
          '';
          type =
            with lib.types;
            nullOr (oneOf [
              path
              lines
              attrs
            ]);
          default = null;
          defaultText = lib.literalMD "";
        };
        semantic = lib.mkOption {
          description = ''
            A scheme following the Material You semantic color standard, using
            role-based color names (e.g. `primary`, `surface`, `on_surface`)
            as produced natively by matugen.

            This preserves more semantic information than a base16 conversion,
            allowing themes to use purpose-specific colors rather than abstract
            base slots.

            See https://m3.material.io/styles/color/roles for the full role reference

            This can be a path to a file, a string of YAML, or an attribute set.

            Used only if the corresponding generator is not set.

            The value is normalized to JSON before being passed to `mappingFunction`.
          '';
          type =
            with lib.types;
            nullOr (oneOf [
              path
              lines
              attrs
            ]);
          default = null;
          defaultText = lib.literalMD "";
        };
      };
    };

    override = lib.mkOption {
      description = ''
        Attribute overrides applied to the final base16 palette just before it is
        converted into `config.lib.stylix.colors`.

        This happens *after* palette generation and `mappingFunction`, but *before*
        the scheme is consumed by base16.nix.

        This can be used to tweak or fix individual base16 colors regardless of how
        they were generated (manual, generated, or mapped).

        The structure must match a base16 scheme (e.g. `{ base00 = "000000"; }`).
      '';
      type = lib.types.attrs;
      default = { };
    };

    base16 = lib.mkOption {
      description = "The base16.nix library.";
      internal = true;
      readOnly = true;
    };

    inputs = lib.mkOption {
      description = "Inputs of the Stylix flake.";
      internal = true;
      readOnly = true;
    };
  };

  config = {
    assertions = [
      {
        assertion = mapped.palette.base16 != null;
        message =
          "stylix: base16 palette is null after mappingFunction.\n"
          + "You must provide one of:\n"
          + "  - stylix.palette.generators.base16\n"
          + "  - stylix.palette.manual.base16\n"
          + "  - a mappingFunction that derives base16 (e.g. semantic -> base16).";
      }
    ];
    # This attrset can be used like a function too, see
    # https://github.com/SenchoPens/base16.nix/blob/b390e87cd404e65ab4d786666351f1292e89162a/README.md#theme-step-22
    lib.stylix.colors =
      (cfg.base16.mkSchemeAttrs (
        mapped.palette.base16
        // {
          author = "Stylix";
          scheme = "Stylix";
          slug = "stylix";
        }
      )).override
        cfg.override;

    stylix.generated.fileTree = {
      # The raw output of the palette generator.
      "stylix/generated/base16.json" = lib.mkIf (
        cfg.palette.generators.base16 != null
      ) { source = cfg.palette.generators.base16 cfg.polarity cfg.image; };

      "stylix/generated/base24.json" = lib.mkIf (
        cfg.palette.generators.base24 != null
      ) { source = cfg.palette.generators.base24 cfg.polarity cfg.image; };

      "stylix/generated/semantic.json" = lib.mkIf (
        cfg.palette.generators.semantic != null
      ) { source = cfg.palette.generators.semantic cfg.polarity cfg.image; };
      # Keep these just it used to be kept before to prevent regenerating palettes if it didn't change but don't keep the generator packages in store.

      # The current palette, with overrides applied.
      "stylix/palette.json".source = config.lib.stylix.colors {
        template = ./palette.json.mustache;
        extension = ".json";
      };

      # We also provide a HTML version which is useful for viewing the colors
      # during development.
      "stylix/palette.html".source = config.lib.stylix.colors {
        template = ./palette.html.mustache;
        extension = ".html";
      };
    };
  };
}
