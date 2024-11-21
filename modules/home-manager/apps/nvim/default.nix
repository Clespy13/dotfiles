{ config, lib, pkgs, inputs, ... }:
{
  options.myHome = {
    nvim.enable =
      lib.mkEnableOption "Enable nvim";
  };

  config = lib.mkIf config.myHome.nvim.enable {
    programs.neovim =
      let
        toLua = str: "lua << EOF\n${str}\nEOF\n";
        toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
      in
      {
        enable = true;

        vimAlias = true;
        vimdiffAlias = true;

        extraPackages = with pkgs; [
          lua-language-server
          yaml-language-server
          nodePackages.typescript-language-server
          nginx-language-server
          dockerfile-language-server-nodejs
          cmake-language-server
          ansible-language-server
          csslint
          nodePackages.vscode-langservers-extracted
          libclang
          pyright

          xclip
          wl-clipboard
        ];

        plugins = with pkgs.vimPlugins; [
          {
            plugin = catppuccin-nvim;
            config = ''colorscheme catppuccin-mocha'';
          }

          vim-automkdir
          dashboard-nvim
          neodev-nvim

          rose-pine
          {
            plugin = lualine-nvim;
            config = toLuaFile ./config/plugins/lualine.lua;
          }

          nvim-lsp-notify
          nvim-lint
          which-key-nvim

          {
            plugin = telescope-zoxide;
            config = toLuaFile ./config/plugins/telescope.lua;
          }

          plenary-nvim
          todo-comments-nvim

          {
            plugin = nvim-lspconfig;
            config = toLuaFile ./config/plugins/lsp.lua;
          }

          base16-nvim

          {
            plugin = nvim-cmp;
            config = toLuaFile ./config/plugins/cmp.lua;
          }

          cmp-buffer
          cmp-path
          cmp-nvim-lsp
          cmp-nvim-lua
          vim-astro
          cmp_luasnip

          luasnip
          friendly-snippets

          {
            plugin = nvim-autopairs;
            config = toLuaFile ./config/plugins/autopairs.lua;
          }

          {
            plugin = nvim-colorizer-lua;
            config = toLuaFile ./config/plugins/colorizer.lua;
          }

          {
            plugin = formatter-nvim;
            config = toLuaFile ./config/plugins/formatter.lua;
          }

          {
            plugin = (nvim-treesitter.withPlugins (p: [
              p.tree-sitter-nix
              p.tree-sitter-vim
              p.tree-sitter-bash
              p.tree-sitter-lua
              p.tree-sitter-python
              p.tree-sitter-json
              p.tree-sitter-c
            ]));
          }
         ];

         extraLuaConfig = ''
            ${builtins.readFile ./config/config/options.lua}
            ${builtins.readFile ./config/config/keymaps.lua}
            ${builtins.readFile ./config/config/autocmds.lua}
         '';
      };

    home = {
      file = {
        ".config/nvim" = {
          source = ./config;
          recursive = true;
        };
      };
    };
  };
}
