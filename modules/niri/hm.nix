{ mkTarget, ... }:
mkTarget {
  config = [
    ({ colors, ... }: with colors.withHashtag;
      {
        wayland.windowManager.niri.settings = {
          layout = {
            border = {
              active-color = base0D;
              inactive-color = base03;
              urgent-color = base08;
            };

            focus-ring = {
              active-color = base0D;
              inactive-color = base03;
              urgent-color = base08;
            };

            insert-hint.color = "${base0D}80";
          };

          recent-windows.highlight = {
            active-color = base0D;
            urgent-color = base08;
          };
        };
      })

    ({ cursor, ... }: {
      wayland.windowManager.niri.settings = {
        cursor = {
          xcursor-theme = cursor.name;
          xcursor-size = cursor.size;
        };
      };
    })
  ];
}
