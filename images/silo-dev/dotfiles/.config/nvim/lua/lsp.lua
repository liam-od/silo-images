-- https://neovim.io/doc/user/lsp/
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
		local opts = { buffer = event.buf, silent = true }

		if client.name == "ruff" then
			client.server_capabilities.hoverProvider = false
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false
		end

		vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "grr", function()
			require("mini.extra").pickers.lsp({ scope = "references" })
		end, {
			buffer = event.buf,
			desc = "LSP references",
			silent = true,
		})

		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, event.buf, {
				autotrigger = true,
			})
			vim.keymap.set("i", "<C-Space>", vim.lsp.completion.get, {
				buffer = event.buf,
				desc = "LSP completion",
				silent = true,
			})
		end
	end,
})

vim.diagnostic.config({
	virtual_text = false,
	float = { border = "rounded" },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = "󰠠 ",
			[vim.diagnostic.severity.INFO] = " ",
		},
	},
})

vim.lsp.config("gopls", {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_markers = { "go.work", "go.mod", ".git" },
	settings = {
		gopls = {
			semanticTokens = true,
			staticcheck = true,
		},
	},
})

vim.lsp.config("lua_ls", {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
				},
			},
		},
	},
})

vim.lsp.config("pyright", {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", ".git" },
	settings = {
		python = {
			analysis = {
				diagnosticMode = "openFilesOnly",
				typeCheckingMode = "basic",
			},
		},
	},
})

vim.lsp.config("ruff", {
	cmd = { "ruff", "server" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
	init_options = {
		settings = {
			configuration = vim.fn.stdpath("config") .. "/ruff.toml",
		},
	},
})

vim.lsp.config("ansiblels", {
	cmd = { "ansible-language-server", "--stdio" },
	filetypes = { "yaml.ansible" },
	root_markers = { "ansible.cfg" },
	settings = {
		ansible = {
			validation = {
				enabled = true,
				lint = {
					enabled = true,
					path = "ansible-lint",
				},
			},
		},
	},
})

vim.lsp.config("texlab", {
	cmd = { "texlab" },
	filetypes = { "tex", "bib" },
	root_markers = { ".latexmkrc", ".git" },
})

vim.lsp.enable({
	"gopls",
	"lua_ls",
	"pyright",
	"ruff",
	"ansiblels",
	"texlab",
})
