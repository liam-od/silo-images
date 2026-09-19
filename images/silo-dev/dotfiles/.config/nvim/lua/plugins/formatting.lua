local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		go = { "goimports" },
		lua = { "stylua" },
		yaml = { "prettierd" },
		["yaml.ansible"] = { "prettierd" },
		tex = { "latexindent" },
		python = { "ruff_organize_imports", "ruff_format" },
	},
	formatters = {
		latexindent = {
			prepend_args = { "-g=/dev/null" },
		},
	},
	default_format_opts = {
		timeout_ms = 1000,
		lsp_format = "never",
	},
	format_on_save = function(bufnr)
		local filetype = vim.bo[bufnr].filetype

		if filetype == "python" then
			return { formatters = { "ruff_organize_imports" } }
		end

		local enabled = {
			go = true,
			lua = true,
			yaml = true,
			["yaml.ansible"] = true,
			tex = true,
		}

		return enabled[filetype] and {} or nil
	end,
})

vim.keymap.set("x", "<leader>f", function()
	conform.format({ async = true })
end, { desc = "Format selection" })
