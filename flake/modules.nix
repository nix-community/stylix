{ inputs, self, ... }:
{
  flake = {
    nixosModules.stylix =
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
