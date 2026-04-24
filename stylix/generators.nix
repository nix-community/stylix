{
  pkgs,
  lib,
  config,
}:
let
  mkMatugen =
    {
      name,
      jqSelector,
      keyCase,
    }:
    {
      contrast ? 0.0,
      filter ? "lanczos3",
      lightnessDark ? 0.0,
      lightnessLight ? 0.0,
      scheme ? "content",
    }:
    let
      validFilters = [
        "catmull-rom"
        "gaussian"
        "lanczos3"
        "nearest"
        "triangle"
      ];
      validSchemes = [
        "content"
        "expressive"
        "fidelity"
        "fruit-salad"
        "monochrome"
        "neutral"
        "rainbow"
        "tonal-spot"
        "vibrant"
      ];
      validate = cond: msg: lib.throwIf cond "stylix: matugen ${msg}";
      applyChecks =
        value:
        builtins.foldl' (acc: f: f acc) value [
          (validate (
            contrast < -1.0 || contrast > 1.0
          ) "contrast must be between -1.0 and 1.0, got ${toString contrast}")
          (validate (
            lightnessDark > 1.0
          ) "lightnessDark must be <= 1.0, got ${toString lightnessDark}")
          (validate (
            lightnessLight < -1.0
          ) "lightnessLight must be >= -1.0, got ${toString lightnessLight}")
          (validate (!lib.elem filter validFilters)
            "filter must be one of ${lib.concatStringsSep ", " validFilters}, got ${filter}"
          )
          (validate (!lib.elem scheme validSchemes)
            "scheme must be one of ${lib.concatStringsSep ", " validSchemes}, got ${scheme}"
          )
        ];
    in
    applyChecks (
      polarity: image:
      let
        raw =
          pkgs.runCommand "palette-${name}-raw.json"
            {
              nativeBuildInputs = [ pkgs.matugen ];
              env = {
                CONTRAST = toString contrast;
                FILTER = filter;
                LIGHTNESSDARK = toString lightnessDark;
                LIGHTNESSLIGHT = toString lightnessLight;
                SCHEME = "scheme-${scheme}";
                POLARITY = polarity;
                IMAGE = image;
              };
            }
            ''
              matugen \
                --contrast "$CONTRAST" \
                --lightness-dark "$LIGHTNESSDARK" \
                --lightness-light "$LIGHTNESSLIGHT" \
                --dry-run \
                --include-image-in-json false \
                --json strip \
                --mode "$POLARITY" \
                --resize-filter "$FILTER" \
                --type "$SCHEME" \
                --source-color-index 0 \
                image \
                "$IMAGE" \
                | sed -E 's/"image":[[:space:]]*"[^"]*",?//g' \
                > $out
            '';
      in
      pkgs.runCommand "palette-${name}.json"
        {
          nativeBuildInputs = [ pkgs.jq ];
          env = {
            POLARITY = polarity;
            RAW = raw;
          };
        }
        ''
          jq --arg polarity "$POLARITY" \
            '${jqSelector} | with_entries(.key |= (${keyCase} | sub("^BASE"; "base"))) | map_values(.[$polarity].color)' \
            "$RAW" > $out
        ''
    );
in
{
  base16 = {
    tinty =
      polarity: image:
      pkgs.runCommand "palette-base16.json"
        {
          nativeBuildInputs = [
            pkgs.tinty
            pkgs.yq-go
          ];
          env = {
            HOME = "/build";
            POLARITY = polarity;
            IMAGE = image;
          };
        }
        ''
          tinty generate-scheme --system base16 --variant "$POLARITY" "$IMAGE" \
            | yq -o=json \
            > $out
        '';
    matugen = mkMatugen {
      name = "base16";
      jqSelector = ".base16";
      keyCase = "ascii_upcase";
    };
  };

  base24 = {
    tinty =
      polarity: image:
      pkgs.runCommand "palette-base24.json"
        {
          nativeBuildInputs = [
            pkgs.tinty
            pkgs.yq-go
          ];
          env = {
            HOME = "/build";
            POLARITY = polarity;
            IMAGE = image;
          };
        }
        ''
          tinty generate-scheme --system base24 --variant "$POLARITY" "$IMAGE" \
            | yq -o=json \
            > $out
        '';
  };

  semantic.matugen = mkMatugen {
    name = "semantic";
    jqSelector = ".colors";
    keyCase = "ascii_downcase";
  };
}
