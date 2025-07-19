{ mkTarget, ... }:
mkTarget {
  name = "lazygit";
  humanName = "lazygit";

  config =
    { colors }:
    {
      programs.lazygit.settings.gui.theme = with colors.withHashtag; {
        activeBorderColor = [
          base0D
          "bold"
        ];
        inactiveBorderColor = [ base03 ];
        searchingActiveBorderColor = [
          base04
          "bold"
        ];
        optionsTextColor = [ base06 ];
        selectedLineBgColor = [ base03 ];
        cherryPickedCommitBgColor = [ base02 ];
        cherryPickedCommitFgColor = [ base03 ];
        unstagedChangesColor = [ base08 ];
        defaultFgColor = [ base05 ];
      };
    };
}
