require("mason-tool-installer").setup({
	ensure_installed = {
		-- lua
		"stylua",
		-- bash
		"shfmt"
	},
})
