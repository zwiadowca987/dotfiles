require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map({ "n", "v", "i" }, "<ScrollWheelUp>", "<C-Y>", { desc = "Przewiń do góry o 1 linijkę" })
map({ "n", "v", "i" }, "<ScrollWheelDown>", "<C-E>", { desc = "Przewiń w dół o 1 linijkę" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
