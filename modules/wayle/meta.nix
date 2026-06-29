{ lib, ... }:
{
  name = "Wayle";
  homepage = "https://github.com/wayle-rs/wayle";
  maintainers = [ lib.maintainers.csanthiago ];
  description = ''
    A Wayland desktop shell with the bar, notifications, OSD, wallpaper, and
    device controls built in. Written in Rust with GTK4 and Relm4.
  '';
}
