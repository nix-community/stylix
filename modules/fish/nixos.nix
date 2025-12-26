{ mkTarget, ... }:
mkTarget {
  config =
    { colors, inputs }:
    {
      programs.fish.interactiveShellInit = import ./prompt.nix {
        inherit colors inputs;
      };
    };
}
