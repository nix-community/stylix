{ lib, ... }:
{
  name = "Television";
  homepage = "https://github.com/alexpasmantier/television";
  maintainers = [ lib.maintainers.csanthiago ];
  description = ''
    Fast, portable fuzzy finder for the terminal. It lets you search in
    real-time through any kind of data source such as files, text, git
    repositories, environment variables, docker containers, and more.
  '';
}
