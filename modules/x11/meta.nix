{ lib, ... }: {
  name = "X11";
  homepage = "https://www.x.org";
  maintainers = with lib.maintainers; [
    panchoh
    zmberber
  ];
}
