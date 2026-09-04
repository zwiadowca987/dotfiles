require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
vim.opt.backup = true
vim.opt.backupdir = "."

vim.filetype.add({
  pattern = {
    [".*"] = function(path, bufnr)
      local line = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1] or ""

      if line:match("^#!.*/env%s+%-S%s+uv%s+run%s+%-%-script") then
        return "python"
      end
    end,
  },
})
