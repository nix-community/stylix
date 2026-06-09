{ mkTarget, ... }:
mkTarget {
  name = "neomutt";
  humanName = "NeoMutt";

  config =
    { colors }:
    {
      programs.neomutt = {
        settings = {
           color_directcolor = "yes";
        };
        extraConfig = ''
          source "${
            colors {
              template = ./base16-stylix.muttrc.mustache;
              extension = ".muttrc";
            }
          }"
        '';
      };
    };
}
