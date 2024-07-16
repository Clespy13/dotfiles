{ config, pkgs, inputs, ... }:
{
  nixpkgs = {
    overlays = [
      (final: prev: {
        vimPlugins = prev.vimPlugins // {
          color-tiger-vim = prev.vimUtils.buildVimPlugin {
            name = "tiger-vim";
            src = inputs.plugin-vim-tiger;
          };
        };
       })
    ];
  };


  programs.neovim =
    let
      toLua = str: "lua << EOF\n${str}\nEOF\n";
      toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
      # vim-tiger = pkgs.vimUtils.buildVimPlugin {
      #   name = "vim-tiger";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "chclouse";
      #     repo = "tiger-vim";
      #     rev = "568f7b39ba53fea28ebd910bb48c8d2f48d79059";
      #     sha256 = "0nkv966ipd4l7qsyd8nbddad3hrvbl2jn6vgaafw444c9vqixpcd";
      #   };
      # };
      #        fine-cmdline = pkgs.vimUtils.buildVimPlugin {
      #            name = "fine-cmdline";
      #            src = pkgs.fetchFromGitHub {
      #                owner = "VonHeikemen";
      #                repo = "fine-cmdline.nvim";
      #                rev = "dd676584145d62b30d7e8dbdd011796a8f0a065f";
      #                sha256 = "0gr8lnklbmdrv0qpypqz03z4k51d0n98j118q0vnjfb456631p63";
      #            };
      #        };
      #        comment-box = pkgs.vimUtils.buildVimPlugin {
      #            name = "comment-box";
      #            src = pkgs.fetchFromGitHub {
      #                owner = "LudoPinelli";
      #                repo = "comment-box.nvim";
      #                rev = "06bb771690bc9df0763d14769b779062d8f12bc5";
      #                sha256 = "182wfx8q30ingkkrr0xs4r9zf1rf0b8wp2l8pi8hds0cpzc8vfvx";
      #            };
      #        };
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
        libclang

        xclip
        wl-clipboard
      ];

      plugins = with pkgs.vimPlugins; [
        {
          plugin = catppuccin-nvim;
          config = ''colorscheme catppuccin-mocha'';
        }
        # {
        #   plugin = nvim-notify;
        #   type = "lua";
        #   config = toLuaFile ./nvim/plugins/notify.lua;
        # }

        vim-automkdir
        dashboard-nvim
        neodev-nvim

        rose-pine
        {
          plugin = lualine-nvim;
          config = toLuaFile ./nvim/plugins/lualine.lua;
        }

        nvim-lsp-notify
        nvim-lint
        which-key-nvim

        {
          plugin = telescope-zoxide;
          config = toLuaFile ./nvim/plugins/telescope.lua;
        }

        plenary-nvim
        todo-comments-nvim

        {
          plugin = nvim-lspconfig;
          config = toLuaFile ./nvim/plugins/lsp.lua;
        }

        base16-nvim

        {
          plugin = nvim-cmp;
          config = toLuaFile ./nvim/plugins/cmp.lua;
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
          config = toLuaFile ./nvim/plugins/autopairs.lua;
        }

        {
          plugin = nvim-colorizer-lua;
          config = toLuaFile ./nvim/plugins/colorizer.lua;
        }

        {
          plugin = formatter-nvim;
          config = toLuaFile ./nvim/plugins/formatter.lua;
        }

        #{
        #  plugin = gitsigns-nvim;
        #  type = "lua";
        #  config = toLuaFile ./nvim/plugins/gitsigns.lua;
        #}
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
          ${builtins.readFile ./nvim/config/options.lua}
          ${builtins.readFile ./nvim/config/keymaps.lua}
          ${builtins.readFile ./nvim/config/autocmds.lua}
       '';
    };

  home = {
    file = {
      ".config/nvim" = {
        source = ./nvim;
        recursive = true;
      };
    };
  };
}
