{ config, lib, ... }:
{
  stylix.testbed.ui.command = {
    terminal = true;
    text = "nvim flake-parts/flake.nix";
  };

  environment.systemPackages = lib.singleton (
    config.lib.stylix.testbed.makeNixvim config.stylix.targets.nixvim.exportedModule
  );
}
