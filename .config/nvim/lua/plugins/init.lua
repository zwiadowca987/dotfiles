return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "typst", "org", "markdown", "lilypond" },  -- tutaj dodajesz kolejne typy
        callback = function()
          require("cmp").setup.buffer({
            sources = {
              { name = "nvim_lsp" },
              { name = "luasnip" },
              { name = "path" },
            },
          })
        end,
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "lilypond",
        callback = function()
          require("cmp").setup.buffer({
            sources = {
              { name = "dictionary", keyword_length = 2 },
            },
          })
        end,
      })
      return opts
    end,
  },
  {
    "uga-rosa/cmp-dictionary",
    dependencies = { "hrsh7th/nvim-cmp" },
    ft = "lilypond",
    config = function()
      local dict_dir = vim.fn.stdpath("data") .. "/lazy/nvim-lilypond-suite/lilywords"
      local dicts = vim.fn.glob(dict_dir .. "/*", false, true)
      require("cmp_dictionary").setup({
        paths = dicts,
        exact_length = 2,
      })
    end,
  },
  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
