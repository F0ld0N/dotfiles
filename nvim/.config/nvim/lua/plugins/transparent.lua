return {
  "folke/tokyonight.nvim", -- Или твоя основная тема
  lazy = false,
  opts = {
    transparent = true, -- У многих современных тем (tokyonight, catppuccin) есть этот параметр
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    },
  },
}
