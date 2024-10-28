local null_list = require("plugins.settings.null-list")
local functions = require("functions")

return {
    'nvimtools/none-ls.nvim',
    config = function()
        local null_ls = require("null-ls")
        local none_sources = functions.format_null(null_list)

        null_ls.setup({
            sources = none_sources
		})
		vim.keymap.set('n', '<leader>gf', vim.lsp.buf.format, {})

	end
}

