local ok, _ = pcall(vim.cmd, 'colorscheme onenord')

-- Highlight the region on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = num_au,
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual", timeout = 120 })
    end,
})
