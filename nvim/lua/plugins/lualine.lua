local customtokyonight = require("lualine.themes.tokyonight")
customtokyonight.normal.a.bg = "None" --terminal color
customtokyonight.normal.b.bg = nil
customtokyonight.normal.c.bg = "None"
return {
  {
    "nvim-lualine/lualine.nvim",
    options = { theme = "customtokyonight" },
  },
}
