require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls", -- lua
        "clangd", -- C/CPP
        "cmake", -- cmake
--        "dockerls",
--       "docker_compose_language_service",
        "marksman", -- markdown
        "pyre", -- python
        "rust_analyzer",
    }
})

local on_attach = function(_, _)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
    vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {})
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
end

require("lspconfig").lua_ls.setup {
    on_attach = on_attach
}

require("lspconfig").clangd.setup {
    on_attach = on_attach
}

require("lspconfig").pyre.setup {
    on_attach = on_attach
}

require("lspconfig").rust_analyzer.setup {
    on_attach = on_attach
}

require("lspconfig").marksman.setup {
    on_attach = on_attach
}

require("lspconfig").cmake.setup {
    on_attach = on_attach
}

