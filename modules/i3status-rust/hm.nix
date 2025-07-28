{ mkTarget, lib, ... }:
let
  bar =
    { colors, opacity }:
    let
      opacityHex = lib.toHexString (builtins.ceil (opacity.desktop * 255));
    in
    lib.mapAttrs (n: v: if lib.hasSuffix "_bg" n then v + opacityHex else v) (
      with colors.withHashtag;
      {
        idle_bg = base00;
        idle_fg = base05;
        info_bg = base09;
        info_fg = base00;
        good_bg = base01;
        good_fg = base05;
        warning_bg = base0A;
        warning_fg = base00;
        critical_bg = base08;
        critical_fg = base00;
        separator_bg = base00;
        separator_fg = base05;
      }
    );
in
mkTarget {
  name = "i3status-rust";
  humanName = "i3status-rust";

  extraOptions.barNames = lib.mkOption {
    type = with lib.types; listOf str;
    default = [ ];
    description = "i3status-rust bars to apply theming to.";
    example = [ "default" ];
  };

  imports = lib.singleton (
    { config, ... }:
    {
      lib.stylix.i3status-rust.bar =
        lib.warn
          "stylix: `config.lib.stylix.i3status-rust.bar` has been replace with `config.stylix.targets.i3status-rust.barNames` and will be removed after 26.11."
          (bar {
            inherit (config.lib.stylix) colors;
            inherit (config.stylix) opacity;
          });
    }
  );

  configElements =
    {
      cfg,
      colors,
      opacity,
    }:
    {
      programs.i3status-rust.bars = lib.genAttrs cfg.barNames (
        _: bar { inherit colors opacity; }
      );
    };
}
