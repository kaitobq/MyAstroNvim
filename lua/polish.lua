-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Make Neovim background transparent (for terminal opacity like WezTerm).
local hl = vim.api.nvim_set_hl
hl(0, "Normal", { bg = "none" })
hl(0, "NormalNC", { bg = "none" })
hl(0, "SignColumn", { bg = "none" })
hl(0, "EndOfBuffer", { bg = "none" })
hl(0, "VertSplit", { bg = "none" })
hl(0, "NormalFloat", { bg = "none" })
hl(0, "FloatBorder", { bg = "none" })
