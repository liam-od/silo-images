local icons = require("mini.icons")
icons.setup()
icons.mock_nvim_web_devicons()

require("mini.pairs").setup()

vim.env.RIPGREP_CONFIG_PATH = vim.fn.stdpath("config") .. "/ripgreprc"

local pick = require("mini.pick")
pick.setup()
require("mini.extra").setup()

local function project_source()
	return {
		cwd = vim.fs.root(0, ".git") or vim.fn.getcwd(),
		tool = "rg",
	}
end

vim.keymap.set("n", "<leader>ff", function()
	local source = project_source()
	pick.builtin.files({ tool = source.tool }, { source = { cwd = source.cwd } })
end, { desc = "Find files" })

vim.keymap.set("n", "<leader>fs", function()
	local source = project_source()
	pick.builtin.grep_live({ tool = source.tool }, { source = { cwd = source.cwd } })
end, { desc = "Grep files" })

vim.keymap.set("n", "<leader>fF", function()
	pick.builtin.files(nil, { source = { cwd = vim.env.HOME } })
end, { desc = "Find files from home" })

vim.keymap.set("n", "<leader>fS", function()
	pick.builtin.grep_live(nil, { source = { cwd = vim.env.HOME } })
end, { desc = "Grep files from home" })

local diff = require("mini.diff")
diff.setup({
	view = {
		style = "sign",
	},
	mappings = {
		apply = "",
		reset = "",
		textobject = "",
	},
})

vim.keymap.set("n", "<leader>gd", function()
	if diff.get_buf_data() then
		diff.toggle_overlay()
	else
		vim.notify("No git diff available for this buffer", vim.log.levels.INFO)
	end
end, { desc = "Toggle Git diff overlay" })
