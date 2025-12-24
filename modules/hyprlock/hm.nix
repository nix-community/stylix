{ mkTarget, lib, ... }:
mkTarget {
  imports = [
    (lib.mkRenamedOptionModuleWith {
      from = [
        "stylix"
        "targets"
        "hyprlock"
        "useWallpaper"
      ];
      sinceRelease = 2605;
      to = [
        "stylix"
        "targets"
        "hyprlock"
        "image"
        "enable"
      ];
    })
  ];

  config = [
    (
      { image }:
      {
        programs.hyprlock.settings.background.path = image;
      }
    )
    (
      { colors }:
      {
        programs.hyprlock.settings = with colors; {
          background = {
            color = "rgb(${base00})";
          };
          input-field = {
            outer_color = "rgb(${base03})";
            inner_color = "rgb(${base00})";
            font_color = "rgb(${base05})";
            fail_color = "rgb(${base08})";
            check_color = "rgb(${base0A})";
          };
        };
      }
    )
  ];
}
