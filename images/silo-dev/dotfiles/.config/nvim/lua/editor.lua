-- https://neovim.io/doc/user/vim_diff.html#nvim-defaults
-- https://github.com/neovim/neovim/tree/master/runtime/ftplugin
vim.g.clipboard = "osc52"
vim.g.tex_flavor = "latex"

vim.o.undofile = true
vim.o.number = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.opt.completeopt = { "menu", "menuone", "noselect", "popup" }
vim.o.cursorline = true
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
vim.o.wrap = false
vim.o.signcolumn = "yes"

local function yaml_filetype(path)
	local ansible_config_path = vim.fs.find("ansible.cfg", {
		path = vim.fs.dirname(path),
		upward = true,
		type = "file",
		stop = vim.env.HOME,
	})[1]

	return ansible_config_path and "yaml.ansible" or "yaml"
end

vim.filetype.add({
	extension = {
		yml = yaml_filetype,
		yaml = yaml_filetype,
	},
})

vim.keymap.set("n", "zz", "<cmd>write<CR>", { desc = "Save current file", silent = true })
vim.keymap.set("x", "<C-c>", '"+y', { desc = "Copy selection to system clipboard", silent = true })
