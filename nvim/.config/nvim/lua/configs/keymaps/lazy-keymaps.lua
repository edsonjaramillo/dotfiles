local extra_pickers = require("extra-pickers.lazy")
local wk = require("which-key")

wk.add({
	mode = "n",
	{
		"<leader>L",
		group = "Lazy",
	},
	{
		"<leader>Lr",
		extra_pickers.reload_lazy_module,
		desc = "Reload Lazy Module",
	},
	{
		"<leader>Lc",
		extra_pickers.remove_cache_module,
		desc = "Reload Cached Module",
	},
})
