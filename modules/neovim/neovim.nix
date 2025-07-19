mkTarget:
{ lib, pkgs, ... }:
mkTarget {
  name = "neovim";
  humanName = "Neovim";
  options = {
    plugin = lib.mkOption {
      type = lib.types.enum [
        "base16-nvim"
        "mini.base16"
      ];
      default = "mini.base16";
      description = "Plugin used for the colorscheme";
    };
    transparentBackground = {
      main = lib.mkEnableOption "background transparency for the main Neovim window";
      signColumn = lib.mkEnableOption "background transparency for the Neovim sign column";
      numberLine = lib.mkEnableOption "background transparency for the NeoVim number/relativenumber column";
    };

    pluginColorConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
      internal = true;
    };
  };

  config = [
    (
      { colors, cfg }:
      {
        stylix.targets.neovim.pluginColorConfig =
          with colors.withHashtag;
          if cfg.plugin == "base16-nvim" then
            ''
              require('base16-colorscheme').setup({
                base00 = '${base00}', base01 = '${base01}', base02 = '${base02}', base03 = '${base03}',
                base04 = '${base04}', base05 = '${base05}', base06 = '${base06}', base07 = '${base07}',
                base08 = '${base08}', base09 = '${base09}', base0A = '${base0A}', base0B = '${base0B}',
                base0C = '${base0C}', base0D = '${base0D}', base0E = '${base0E}', base0F = '${base0F}'
              })
            ''
          else
            ''
              require('mini.base16').setup({
                palette = {
                  base00 = '${base00}', base01 = '${base01}', base02 = '${base02}', base03 = '${base03}',
                  base04 = '${base04}', base05 = '${base05}', base06 = '${base06}', base07 = '${base07}',
                  base08 = '${base08}', base09 = '${base09}', base0A = '${base0A}', base0B = '${base0B}',
                  base0C = '${base0C}', base0D = '${base0D}', base0E = '${base0E}', base0F = '${base0F}'
                }
              })
            '';
      }
    )
    (
      { cfg }:
      {
        programs.neovim.plugins =
          let
            transparencyCfg = toString (
              lib.optional cfg.transparentBackground.main ''
                vim.cmd.highlight({ "Normal", "guibg=NONE", "ctermbg=NONE" })
                vim.cmd.highlight({ "NonText", "guibg=NONE", "ctermbg=NONE" })
              ''
              ++ lib.optional cfg.transparentBackground.signColumn ''
                vim.cmd.highlight({ "SignColumn", "guibg=NONE", "ctermbg=NONE" })
              ''
              ++ lib.optional cfg.transparentBackground.numberLine ''
                vim.cmd.highlight({ "LineNr", "guibg=NONE", "ctermbg=NONE" })
                vim.cmd.highlight({ "LineNrAbove", "guibg=NONE", "ctermbg=NONE" })
                vim.cmd.highlight({ "LineNrBelow", "guibg=NONE", "ctermbg=NONE" })
              ''
            );
          in
          [
            {
              plugin =
                if cfg.plugin == "mini.base16" then
                  pkgs.vimPlugins.mini-nvim
                else
                  pkgs.vimPlugins.base16-nvim;
              type = "lua";
              config = lib.concatLines [
                cfg.pluginColorConfig
                transparencyCfg
              ];
            }
          ];
      }
    )
  ];
}
