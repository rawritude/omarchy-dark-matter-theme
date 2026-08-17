-- Dark Matter for Neovim.
--
-- Stock Omarchy themes point at an upstream colorscheme plugin. This one has no
-- upstream to point at, so the highlights are defined here and handed to
-- LazyVim as a function -- which is the supported way to supply a colorscheme it
-- cannot `require`.
--
-- Do not be tempted to declare this as a plugin with a local `dir`: lazy.nvim
-- resolves that path at startup and reports "Local plugin does not exist" for
-- every user whose config does not happen to contain it.
--
-- Syntax deliberately reads as a greyscale with one accent, matching the
-- desktop. If you want a conventional rainbow in your editor, replace this file
-- with a normal colorscheme spec; the rest of the theme is unaffected.

local palette = {
  bg = "#000000",
  bg_alt = "#0b0b0b",
  bg_lift = "#171717",
  fg = "#c2c2c2",
  fg_dim = "#626262",
  fg_bright = "#e0e0e0",
  accent = "#d9822b",
  neutral = "#a8a8a8",
  neutral_lo = "#8e8e8e",
  neutral_hi = "#c4c4c4",
  border = "#5a5a5a",
}

local function apply()
  local p = palette
  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end
  vim.o.background = "dark"
  vim.g.colors_name = "dark-matter"

  local set = vim.api.nvim_set_hl
  set(0, "Normal", { fg = p.fg, bg = p.bg })
  set(0, "NormalFloat", { fg = p.fg, bg = p.bg_alt })
  set(0, "FloatBorder", { fg = p.border, bg = p.bg_alt })
  set(0, "CursorLine", { bg = p.bg_alt })
  set(0, "CursorLineNr", { fg = p.accent, bold = true })
  set(0, "LineNr", { fg = p.fg_dim })
  set(0, "Visual", { bg = p.bg_lift })
  set(0, "Search", { fg = p.bg, bg = p.accent })
  set(0, "IncSearch", { fg = p.bg, bg = p.fg_bright })
  set(0, "StatusLine", { fg = p.fg, bg = p.bg_alt })
  set(0, "WinSeparator", { fg = p.bg_lift })
  set(0, "Pmenu", { fg = p.fg, bg = p.bg_alt })
  set(0, "PmenuSel", { fg = p.bg, bg = p.accent })

  -- Lightness carries the structure; the accent carries attention.
  set(0, "Comment", { fg = p.fg_dim, italic = true })
  set(0, "Constant", { fg = p.neutral_hi })
  set(0, "String", { fg = p.neutral })
  set(0, "Identifier", { fg = p.fg })
  set(0, "Function", { fg = p.fg_bright })
  set(0, "Statement", { fg = p.accent })
  set(0, "Keyword", { fg = p.accent })
  set(0, "PreProc", { fg = p.neutral_lo })
  set(0, "Type", { fg = p.neutral_hi })
  set(0, "Special", { fg = p.accent })
  set(0, "Todo", { fg = p.bg, bg = p.accent, bold = true })
  set(0, "Error", { fg = p.bg, bg = p.accent })

  set(0, "DiagnosticError", { fg = p.accent })
  set(0, "DiagnosticWarn", { fg = p.neutral_hi })
  set(0, "DiagnosticInfo", { fg = p.neutral })
  set(0, "DiagnosticHint", { fg = p.fg_dim })

  set(0, "DiffAdd", { fg = p.fg_bright, bg = p.bg_alt })
  set(0, "DiffDelete", { fg = p.fg_dim, bg = p.bg_alt })
  set(0, "DiffChange", { fg = p.neutral, bg = p.bg_alt })
  set(0, "DiffText", { fg = p.accent, bg = p.bg_lift })
end

return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = apply,
    },
  },
}
