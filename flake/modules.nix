{
  inputs,
  self,
  lib,
  ...
}:
{
  flake = {
    nixosModules.stylix =
      # Although the pkgs argument is unused, it is necessary for propagation.
      #
      # deadnix: skip
      { pkgs, ... }@args:
      {
        imports = [
          ../stylix/nixos
          {
            stylix = {
              inherit inputs;
              base16 = inputs.base16.lib args;
              homeManagerIntegration.module = self.homeModules.stylix;
            };
          }
        ];
      };

    homeModules.stylix =
      # Although the pkgs argument is unused, it is necessary for propagation.
      #
      # deadnix: skip
      { pkgs, ... }@args:
      {
        imports = [
          ../stylix/hm
          {
            stylix = {
              inherit inputs;
              base16 = inputs.base16.lib args;
            };
          }
        ];
      };

    darwinModules.stylix =
      # Although the pkgs argument is unused, it is necessary for propagation.
      #
      # deadnix: skip
      { pkgs, ... }@args:
      {
        imports = [
          ../stylix/darwin
          {
            stylix = {
              inherit inputs;
              base16 = inputs.base16.lib args;
              homeManagerIntegration.module = self.homeModules.stylix;
            };
          }
        ];
      };

    nixOnDroidModules.stylix =
      # Although the pkgs argument is unused, it is necessary for propagation.
      #
      # deadnix: skip
      { pkgs, ... }@args:
      {
        imports = [
          ../stylix/droid
          {
            stylix = {
              base16 = inputs.base16.lib args;
              homeManagerIntegration.module = self.homeModules.stylix;
            };
          }
        ];
      };
  };
}
