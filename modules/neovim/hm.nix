{ mkTarget, lib, ... }:
{
  imports = map (module: lib.modules.importApply module mkTarget) [
    ./neovim.nix
    ./neovide.nix
    ./nixvim.nix
    ./nvf.nix
    ./vim.nix
  ];
}
