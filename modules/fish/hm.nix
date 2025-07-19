{ mkTarget, ... }:
mkTarget {
  name = "fish";
  humanName = "Fish";

  config =
    { colors, inputs }:
    {
      programs.fish.interactiveShellInit = import ./prompt.nix {
        inherit colors inputs;
      };
    };
}
