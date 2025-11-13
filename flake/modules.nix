{ inputs, self, ... }:
{
  flake = {
    nixosModules = {
      default = self.nixosModules.stylix;
      stylix =
        { pkgs, ... }@args:
        {
          imports = [
            ../stylix/nixos
            {
              stylix = {
                inherit inputs;
                paletteGenerator =
                  self.packages.${pkgs.stdenv.hostPlatform.system}.palette-generator;
                base16 = inputs.base16.lib args;
                homeManagerIntegration.module = self.homeModules.stylix;
              };
            }
          ];
        };
    };

    homeModules = {
      default = self.homeModules.stylix;
      stylix =
        { pkgs, ... }@args:
        {
          imports = [
            ../stylix/hm
            {
              stylix = {
                inherit inputs;
                paletteGenerator =
                  self.packages.${pkgs.stdenv.hostPlatform.system}.palette-generator;
                base16 = inputs.base16.lib args;
              };
            }
          ];
        };
    };

    darwinModules = {
      default = self.darwinModules.stylix;
      stylix =
        { pkgs, ... }@args:
        {
          imports = [
            ../stylix/darwin
            {
              stylix = {
                inherit inputs;
                paletteGenerator =
                  self.packages.${pkgs.stdenv.hostPlatform.system}.palette-generator;
                base16 = inputs.base16.lib args;
                homeManagerIntegration.module = self.homeModules.stylix;
              };
            }
          ];
        };
    };

    nixOnDroidModules = {
      default = self.nixOnDroidModules.stylix;
      stylix =
        { pkgs, ... }@args:
        {
          imports = [
            ../stylix/droid
            {
              stylix = {
                paletteGenerator =
                  self.packages.${pkgs.stdenv.hostPlatform.system}.palette-generator;
                base16 = inputs.base16.lib args;
                homeManagerIntegration.module = self.homeModules.stylix;
              };
            }
          ];
        };
    };
  };
}
