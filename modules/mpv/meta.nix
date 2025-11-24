{ lib, ... }:
{
  name = "mpv";
  homepage = "https://mpv.io";
  maintainers = with lib.maintainers; [
    da157
    naho
  ];
}
