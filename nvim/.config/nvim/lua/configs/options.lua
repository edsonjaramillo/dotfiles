local g = vim.g
g.mapleader = " "
g.maplocalleader = ","

local o = vim.opt

-- UI: lines, columns, and visuals
o.relativenumber = true -- Show relative line numbers (great for motions)
o.cursorline = true -- Highlight the current line
o.signcolumn = "yes" -- Always show sign column (prevents text shift)
o.wrap = false -- Do not soft-wrap long lines
o.linebreak = true -- If wrap is on, break at word boundaries
o.scrolloff = 8 -- Keep 8 lines visible above/below cursor
o.sidescrolloff = 8 -- Keep columns visible to left/right
o.termguicolors = true -- Enable true color support
o.laststatus = 3 -- Global statusline (one bar for all windows)
o.showmode = false -- Hide -- INSERT -- (statusline usually shows it)

-- Invisible characters and filler
o.list = true -- Show invisible chars using listchars
o.listchars = {
	tab = "» ",
	trail = "·",
	extends = "›",
	precedes = "‹",
	nbsp = "␣",
}
o.fillchars = {
	eob = " ", -- Hide ~ on empty lines
	fold = " ",
	foldsep = " ",
	vert = "│",
}

-- Splits and windows
o.splitright = true -- Vertical splits open to the right
o.splitbelow = true -- Horizontal splits open below
o.equalalways = false -- Don't auto-resize splits on window close

-- Tabs, indentation, and formatting
o.tabstop = 4 -- Visual width of a tab character
o.shiftwidth = 4 -- Indent width for >> << and autoindent
o.smartindent = true -- Smarter auto-indenting on new lines
o.shiftround = true -- Round indents to multiples of shiftwidth

-- Search
o.ignorecase = true -- Case-insensitive search by default
o.smartcase = true -- Case-sensitive if search contains capitals
o.incsearch = true -- Show matches while typing
o.hlsearch = true -- Highlight search matches

-- Completion and UX
o.completeopt = { "menu", "menuone", "noselect" }
-- menu: use popup menu; menuone: show even with 1 match; noselect: don't preselect
o.pumheight = 10 -- Max items in completion popup
o.shortmess:append("c") -- Reduce completion messages
o.updatetime = 200 -- Faster CursorHold, diagnostics, git signs
o.timeoutlen = 400 -- Mapped sequence timeout (snappy, but not too short)

-- Files, backups, and undo
o.undofile = true -- Persistent undo across sessions
o.swapfile = false -- Disable swap files
o.backup = false -- Disable backup files
o.writebackup = false -- Don't write backup before overwriting

-- System integration
o.clipboard = "unnamedplus" -- Use system clipboard for all yanks/pastes
o.mouse = "a" -- Enable mouse in all modes

-- Folding (simple defaults; enhance with Treesitter if you use it)
o.foldenable = true
o.foldlevel = 99 -- Open most folds by default
o.foldmethod = "expr" -- Fold by expression
o.foldexpr = "nvim_treesitter#foldexpr()" -- Use Treesitter for folding if available

-- Whitespace and file handling niceties
o.backspace = { "indent", "eol", "start" } -- Make backspace behave sensibly
o.confirm = true -- Confirm before closing unsaved buffers
o.hidden = true -- Allow switching buffers without saving
o.fileencoding = "utf-8" -- Default file encoding
o.spell = false -- Spellcheck off by default; toggle when needed

-- Cursor appearance and behavior
o.guicursor = table.concat({
	"a:blinkon0", -- no blinking in any mode

	-- Normal mode: white block with black text
	"n:block-Cursor/lCursor",

	-- Visual modes: blue block with black text
	"v:block-VisualCursor/lCursor",
	"V:block-VisualCursor/lCursor",

	-- Insert (and cmdline-insert): thin green bar
	"i-ci:ver25-iCursor/lCursor",

	-- (Optional) Replace modes: thin red line
	"r-cr:vej25-ReplaceCursor/lCursor",
}, ",")

-- Define the highlight groups used above
local sethl = vim.api.nvim_set_hl
sethl(0, "Cursor", { fg = "#030303", bg = "#fafafa" }) -- normal
sethl(0, "lCursor", { fg = "#030303", bg = "#fafafa" }) -- langmap cursor (match normal)
sethl(0, "VisualCursor", { fg = "#030303", bg = "#409cff" }) -- blue
sethl(0, "iCursor", { fg = "#030303", bg = "#24d064" }) -- green
sethl(0, "ReplaceCursor", { fg = "#030303", bg = "#e35659" }) -- optional
