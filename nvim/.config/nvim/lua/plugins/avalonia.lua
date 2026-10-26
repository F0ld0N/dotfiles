return {
  "Johanw123/avalonia.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "neovim/nvim-lspconfig",
  },
  ft = { "axaml", "xaml" }, -- загружать только для этих файлов
  opts = {
    -- Путь к серверу. Если ты уже скачал его в ~/.local/share/nvim/avalonia-lsp/, укажи его тут:
    lsp_path = vim.fn.expand("~/.local/share/nvim/avalonia-lsp/Avalonia"),
    -- Способ отображения превью
    display_method = "html", -- откроет в браузере
  },
  config = function(_, opts)
    local avalonia = require("avalonia")
    avalonia.setup(opts)

    -- Принудительно запускаем LSP для расширений axaml
    avalonia.setup_lsp()
  end,
}
