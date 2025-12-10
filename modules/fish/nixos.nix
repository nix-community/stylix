{ mkTarget, ... }:
mkTarget {
  config =
    { colors, inputs }:
    {
      programs.fish.promptInit = import ./prompt.nix { inherit colors inputs; };
    };
}
