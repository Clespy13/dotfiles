{ config, pkgs, ... }:
{
  programs.neovim =
    let
      toLua = str: "lua << EOF\n${str}\nEOF\n";
      toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
      #        vim-tiger = pkgs.vimUtils.buildVimPlugin {
      #          name = "vim-tiger";
      #          src = pkgs.fetchFromGitHub {
      #            owner = "chclouse";
      #            repo = "tiger-vim";
      #            rev = "568f7b39ba53fea28ebd910bb48c8d2f48d79059";
      #            sha256 = "0nkv966ipd4l7qsyd8nbddad3hrvbl2jn6vgaafw444c9vqixpcd";
      #          };
      #        };
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
      #    plugins = with pkgs.vimPlugins; [
      #        {
      #            plugin = rose-pine;
      #            config = "colorscheme rose-pine";
      #        }
      #        {
      #            plugin = nvim-notify;
      #            config = toLuaFile ./nvim/plugins/notify.lua;
      #        }
      #        comment-box
      #        nvim-gdb
      #        vim-automkdir
      #        dashboard-nvim
      #        galaxyline-nvim
      #        nvim-lsp-notify
      #        vim-tiger
      #        which-key-nvim
      #        nui-nvim
      #        {
      #            plugin = fine-cmdline;
      #            config = toLuaFile ./nvim/plugins/cmd.lua;
      #        }
      #
      #		telescope-z-nvim
      #		plenary-nvim
      #		todo-comments-nvim
      #
      #        mason-nvim
      #	    mason-lspconfig-nvim
      #        {
      #	        plugin = nvim-lspconfig;
      #            config = toLuaFile ./nvim/plugins/lsp.lua;
      #        }
      #
      #		base16-nvim
      #		nvim-cmp
      #		cmp-buffer
      #		cmp-path
      #		cmp-nvim-lsp
      #		cmp-nvim-lua
      #        vim-astro
      #        coc-html
      #        coc-css
      #    ];
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
