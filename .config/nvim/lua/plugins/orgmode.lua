return {
  -- Silnik orgmode
  {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    config = function()
      require("orgmode").setup({
        org_agenda_files = "~/Dokumenty/ObsidianVault/org/**/*",
        org_default_notes_file = "~/Dokumenty/ObsidianVault/org/notatki.org",
        org_startup_indented = false,
        org_adapt_indentation = false,
        org_startup_folded = "showeverything",
      })
    end,
  },

  -- Ładniejsze nagłówki i punkty
  {
    "nvim-orgmode/org-bullets.nvim",
    ft = "org",
    config = function()
      require("org-bullets").setup()
    end,
  },

  -- Podświetlenie nagłówków
  {
    "lukas-reineke/headlines.nvim",
    ft = "org",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("headlines").setup({
        org = {
          headline_highlights = { "Headline1", "Headline2", "Headline3" },
        },
      })
    end,
  },

  -- Wykonywanie bloków kodu
  {
    "michaelb/sniprun",
    branch = "master",
    build = "sh install.sh",
    cmd = { "SnipRun", "SnipClose" },
    config = function()
      require("sniprun").setup({
        display = { "VirtualTextOk" },
        -- display = { "NvimNotify" },
      })
    end,
  },

  -- Fuzzy search po nagłówkach
  {
    "nvim-orgmode/telescope-orgmode.nvim",
    ft = "org",
    dependencies = {
      "nvim-orgmode/orgmode",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("telescope").load_extension("orgmode")
    end,
  },

  -- Autouzupełnianie dla orgmode (nvim-cmp)
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      table.insert(opts.sources, { name = "orgmode" })
      -- usuń buffer source tylko dla org
      opts.sources = vim.tbl_filter(function(s)
        if vim.bo.filetype == "org" and s.name == "buffer" then
          return false
        end
        return true
      end, opts.sources or {})
      return opts
    end,
  },

  {
    "rcarriga/nvim-notify",
    config = function()
    require("notify").setup({
      background_colour = "#000000",
    })
    vim.notify = require("notify")
    end,
  },
}
