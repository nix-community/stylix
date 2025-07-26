{ inputs, self, ... }:
{
  flake.nixosConfigurations.eval-test = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      # keep-sorted start block=yes prefix_order=inputs,self,./,{
      self.stylix.nixosModules.stylix
      ./eval-test.nix
      {
        home-manager.sharedModules = [
          inputs.stylix.homeModules.stylix
        ];
      }
      # keep-sorted end
    ];
  };
}
