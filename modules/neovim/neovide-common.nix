# imported from `modules/nixvim/nixvim.nix`
opacity: {
  extraConfigLua = ''
    if vim.g.neovide then
      vim.g.neovide_normal_opacity = ${toString opacity.terminal}
    end
  '';
}
