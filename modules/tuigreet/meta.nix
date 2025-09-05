{
  name = "TUIgreet";
  homepage = "https://github.com/apognu/tuigreet";
  maintainers = [];
  description = ''
    Applies Stylix colors to TUIgreet by generating an ANSI theme string at
    /etc/tuigreet/stylix.theme. Ensure greetd invokes TUIgreet with a
    `--theme` argument, for example:
    `--theme "$(cat /etc/tuigreet/stylix.theme)"`.
  '';
}
