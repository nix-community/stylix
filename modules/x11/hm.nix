{ mkTarget, ... }:
mkTarget {
  config = [ ({ cursor }: { home.pointerCursor.x11.enable = true; }) ];
}
