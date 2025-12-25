---@type vim.lsp.Config
return {
	cmd = { "nixd" },
	on_attach = function()
		vim.notify("nixd loaded")
	end,
	filetypes = { "nix" },
	root_markers = { "flake.nix" },
}
