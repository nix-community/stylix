{ config, lib, ... }:
{
  stylix.testbed.ui.command = {
    text = "nvim flake-parts/flake.nix";
    useTerminal = true;
  };

  environment.systemPackages = lib.singleton (
    config.lib.stylix.testbed.makeNixvim config.stylix.targets.nixvim.exportedModule
  );
}
