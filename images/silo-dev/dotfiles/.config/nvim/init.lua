vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
	"https://github.com/echasnovski/mini.nvim",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/stevearc/conform.nvim",
})

require("editor")
require("lsp")

require("plugins.treesitter")
require("plugins.colorscheme")
require("plugins.mini")
require("plugins.lualine")
require("plugins.formatting")
