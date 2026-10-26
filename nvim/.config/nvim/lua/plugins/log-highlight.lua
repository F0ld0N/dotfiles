return {
  {
    -- ЗАМЕНЕНО: Новое актуальное имя репозитория, чтобы LazyVim не ругался
    "nvim-mini/mini.hipatterns",
    opts = function(_, opts)
      -- Добавляем наши паттерны в существующие настройки mini.hipatterns
      opts.highlighters = opts.highlighters or {}

      -- Регулярные выражения в стиле Lua (string.find)
      opts.highlighters.serilog_dbg = {
        pattern = "%[DBG%]",
        group = "MiniHipatternsSerilogDbg",
        extmark_opts = { priority = 2000 },
      }
      opts.highlighters.serilog_inf = {
        pattern = "%[INF%]",
        group = "MiniHipatternsSerilogInf",
        extmark_opts = { priority = 2000 },
      }
      opts.highlighters.serilog_wrn = {
        pattern = "%[WRN%]",
        group = "MiniHipatternsSerilogWrn",
        extmark_opts = { priority = 2000 },
      }
      opts.highlighters.serilog_err = {
        pattern = "%[ERR%]",
        group = "MiniHipatternsSerilogErr",
        extmark_opts = { priority = 2000 },
      }
      opts.highlighters.serilog_ftl = {
        pattern = "%[FTL%]",
        group = "MiniHipatternsSerilogFtl",
        extmark_opts = { priority = 2000 },
      }

      -- Подсветка даты и времени в начале строки
      opts.highlighters.serilog_date = {
        pattern = "^%d%d%d%d%-%d%d%-%d%d",
        group = "MiniHipatternsSerilogDate",
        extmark_opts = { priority = 2000 },
      }

      -- Создаем группы подсветки (вызывается один раз при инициализации)
      vim.api.nvim_set_hl(0, "MiniHipatternsSerilogDbg", { fg = "#565f89", italic = true })
      vim.api.nvim_set_hl(0, "MiniHipatternsSerilogInf", { fg = "#9ece6a", bold = true })
      vim.api.nvim_set_hl(0, "MiniHipatternsSerilogWrn", { fg = "#e0af68", bold = true })
      vim.api.nvim_set_hl(0, "MiniHipatternsSerilogErr", { fg = "#f7768e", bold = true })
      vim.api.nvim_set_hl(0, "MiniHipatternsSerilogFtl", { fg = "#ffffff", bg = "#db4b4b", bold = true })
      vim.api.nvim_set_hl(0, "MiniHipatternsSerilogDate", { fg = "#7aa2f7" })
    end,
    init = function()
      -- Отключаем spellcheck для логов, чтобы убрать красные волны
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = "*.log",
        callback = function()
          vim.opt_local.spell = false
        end,
      })
    end,
  },
}
