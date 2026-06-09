require "nvchad.autocmds"

vim.filetype.add({
  extension = {
    ly = "lilypond",
    ily = "lilypond",
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "lilypond",
  callback = function()
    local set = vim.api.nvim_set_hl

    set(0, "lilyFunction", { fg = "#7aa2f7", bold = true })
    set(0, "lilyPitch",    { fg = "#9ece6a" })
    set(0, "lilyMatcher",  { fg = "#bb9af7" })
    set(0, "lilyString",   { fg = "#98c379" })
    set(0, "lilyNumber",   { fg = "#d19a66" })
    set(0, "lilyComment",  { fg = "#5c6370", italic = true })

    set(0, "lilyDynamic",  { fg = "#e06c75", bold = true })
    set(0, "lilySpecial",  { fg = "#c678dd" })
    set(0, "lilyKeyword",  { fg = "#61afef" })
  end,
})
