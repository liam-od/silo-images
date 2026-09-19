local languages = {
	css = "css",
	go = "go",
	html = "html",
	javascript = "javascript",
	javascriptreact = "javascript",
	json = "json",
	python = "python",
	sh = "bash",
	tex = "latex",
	typescript = "typescript",
	typescriptreact = "tsx",
	yaml = "yaml",
	["yaml.ansible"] = "yaml",
}

local parsers = {}
for _, language in pairs(languages) do
	parsers[language] = true
end

if vim.fn.executable("tree-sitter") == 1 then
	require("nvim-treesitter").install(vim.tbl_keys(parsers))
else
	vim.schedule(function()
		vim.notify("nvim-treesitter requires tree-sitter-cli", vim.log.levels.WARN)
	end)
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = vim.tbl_keys(languages),
	callback = function(event)
		local language = languages[vim.bo[event.buf].filetype]
		pcall(vim.treesitter.start, event.buf, language)
	end,
})
