--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- File: plugins/treesitter.lua
-- Description: nvim-treesitter configuration
require('nvim-treesitter') {
    version = false, -- last release is way too old and doesn"t work on Windows
    build = ":TSUpdate",
    opts = {
        -- A list of parser names, or "all"
        ensure_installed = {"python", "dockerfile", "json", "yaml", "markdown", "html", "scss", "css", "vim", "lua", "c", "cpp"},

        highlight = {
            enable = true,
            use_languagetree = true
        },
        indent = {
            enable = true
        },
        autotag = {
            enable = true
        },
        context_commentstring = {
            enable = true,
            enable_autocmd = false
        },
        refactor = {
            highlight_definitions = {
                enable = true
            },
            highlight_current_scope = {
                enable = false
            }
        }
    },
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end
}
