-- Dark Matter has no upstream Neovim colorscheme to point at, so it is defined
-- here against the same palette as colors.toml: true black, no pure white, and
-- differentiation carried by lightness rather than hue.
--
-- Syntax deliberately reads as a greyscale with one accent. If you want a
-- conventional rainbow in your editor, set a different colorscheme here -- the
-- desktop chrome will still be Dark Matter.
return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "dark-matter",
    },
  },
  {
    "rktjmp/lush.nvim",
    lazy = true,
  },
  {
    dir = vim.fn.stdpath("config") .. "/colors",
    name = "dark-matter",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("highlight clear")
      vim.o.background = "dark"
      vim.g.colors_name = "dark-matter"

      local p = {
        bg        = "#000000",
        bg_alt    = "#0b0b0b",
        bg_lift   = "#171717",
        fg        = "#c2c2c2",
        fg_dim    = "#626262",
        fg_bright = "#e0e0e0",
        accent    = "#d9822b",
        neutral   = "#a8a8a8",
        neutral_lo = "#8e8e8e",
        neutral_hi = "#c4c4c4",
        border    = "#5a5a5a",
      }

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
      set(0, "VertSplit", { fg = p.bg_lift })
      set(0, "WinSeparator", { fg = p.bg_lift })
      set(0, "Pmenu", { fg = p.fg, bg = p.bg_alt })
      set(0, "PmenuSel", { fg = p.bg, bg = p.accent })

      -- Syntax: lightness carries the structure, accent carries attention.
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
    end,
  },
}
