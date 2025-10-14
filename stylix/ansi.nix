{
  lib,
  config,
  ...
}: {
  # ANSI helpers (nearest-color mapping) and scheme-sensitive theme string
  config.lib.stylix.ansi = let
    # Default component mapping (Base16 -> semantic UI elements)
    defaultComponents = {
      text = "base05";
      time = "base0C";
      container = "base00";
      border = "base03";
      title = "base0E";
      greet = "base0C";
      prompt = "base0B";
      input = "base0D";
      action = "base0D";
      button = "base0A";
    };

    # Scheme-sensitive nearest ANSI mapping
    # Reference RGB for ANSI names (0..255)
    ansiRGB = {
      black = {
        r = 0;
        g = 0;
        b = 0;
      };
      red = {
        r = 205;
        g = 0;
        b = 0;
      };
      green = {
        r = 0;
        g = 205;
        b = 0;
      };
      yellow = {
        r = 205;
        g = 205;
        b = 0;
      };
      blue = {
        r = 0;
        g = 0;
        b = 205;
      };
      magenta = {
        r = 205;
        g = 0;
        b = 205;
      };
      cyan = {
        r = 0;
        g = 205;
        b = 205;
      };
      white = {
        r = 229;
        g = 229;
        b = 229;
      };

      # Bright variants (standard 16-color set)
      "bright-black" = {
        r = 102;
        g = 102;
        b = 102;
      };
      "bright-red" = {
        r = 255;
        g = 0;
        b = 0;
      };
      "bright-green" = {
        r = 0;
        g = 255;
        b = 0;
      };
      "bright-yellow" = {
        r = 255;
        g = 255;
        b = 0;
      };
      "bright-blue" = {
        r = 0;
        g = 0;
        b = 255;
      };
      "bright-magenta" = {
        r = 255;
        g = 0;
        b = 255;
      };
      "bright-cyan" = {
        r = 0;
        g = 255;
        b = 255;
      };
      "bright-white" = {
        r = 255;
        g = 255;
        b = 255;
      };
    };

    # Access Base16 RGB components from the current scheme and convert to ints
    getRgb = name: comp: lib.toInt (config.lib.stylix.colors."${name}-rgb-${comp}");
    rgbOfBase = name: {
      r = getRgb name "r";
      g = getRgb name "g";
      b = getRgb name "b";
    };
    dist2 = a: b: let
      dr = a.r - b.r;
      dg = a.g - b.g;
      db = a.b - b.b;
    in
      dr * dr + dg * dg + db * db;
    nearestNameFor = baseName: let
      c = rgbOfBase baseName;
      keys = builtins.attrNames ansiRGB;
      scored =
        map (k: {
          name = k;
          d = dist2 c ansiRGB.${k};
        })
        keys;
      sorted = lib.sort (a: b: a.d < b.d) scored;
    in
      (builtins.head sorted).name;

    # Build a theme map and string using nearest ANSI for each component's Base16
    themeMapNearest = let
      comps = defaultComponents;
    in {
      text = nearestNameFor comps.text;
      time = nearestNameFor comps.time;
      container = nearestNameFor comps.container;
      border = nearestNameFor comps.border;
      title = nearestNameFor comps.title;
      greet = nearestNameFor comps.greet;
      prompt = nearestNameFor comps.prompt;
      input = nearestNameFor comps.input;
      action = nearestNameFor comps.action;
      button = nearestNameFor comps.button;
    };

    themeStringNearest =
      lib.concatStringsSep ";"
      (map (
          k: "${k}=" + (builtins.getAttr k themeMapNearest)
        ) [
          "text"
          "time"
          "container"
          "border"
          "title"
          "greet"
          "prompt"
          "input"
          "action"
          "button"
        ]);
  in {
    inherit defaultComponents themeMapNearest themeStringNearest;
  };
}
