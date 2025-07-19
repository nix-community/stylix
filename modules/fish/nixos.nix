{ mkTarget, ... }:
mkTarget {
  name = "fish";
  humanName = "Fish";

  config =
    { colors, inputs }:
    {
      programs.fish.promptInit = import ./prompt.nix { inherit colors inputs; };
    };
}
