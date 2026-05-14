{ lib, ... }:
{
  maintainers = [ lib.maintainers.bricked ];
  name = "GTKSourceView";
  description = ''
    > [!WARNING]
    > GTKSourceView is disabled by default because it causes many packages
    > to no longer be cached in hydra, forcing the user to compile these
    > packages themselves.
  '';
}
