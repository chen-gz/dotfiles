-- init.lua

-- Set leader key to space
vim.g.mapleader = " "

-- Set up lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set up lazy with plugins
require("lazy").setup("plugins")

-- Set options
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.updatetime = 50
vim.opt.clipboard = 'unnamedplus' 
vim.opt.list = true
vim.opt.listchars:append("tab:  ")
vim.opt.listchars:append("trail:·")

vim.opt.mouse = 'a'

-- Keymaps

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
-- vim.keymap.set("n", "<leader>t", ":split term://bash<CR>")
vim.keymap.set("n", "<C-h>", "<C-w>h") -- Move to left window
vim.keymap.set("n", "<C-j>", "<C-w>j") -- Move to lower window
vim.keymap.set("n", "<C-k>", "<C-w>k") -- Move to upper window
vim.keymap.set("n", "<C-l>", "<C-w>l") -- Move to right window
vim.keymap.set("n", "<C-s>", ":w") -- save current buffer 
vim.keymap.set("n", "<leader>fp", "<cmd>Telescope projects<CR>", { desc = "Find Project" })
vim.keymap.set("n", "q", ":quit!<CR>")
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("n", "<leader>tf", ":NvimTreeFindFile<CR>", { desc = "Find current file in NvimTree" })

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

function Lazygit_toggle()
  lazygit:toggle()
end

vim.keymap.set("n", "<leader>g", Lazygit_toggle, { desc = "Toggle lazygit" })

function Run_just_command()
  local command = vim.fn.input("just ")
  if command and command ~= "" then
    local just_term = Terminal:new({ cmd = "just " .. command, hidden = true, direction = "float" })
    just_term:toggle()
  end
end

vim.keymap.set("n", "<leader>j", Run_just_command, { desc = "Run just command in floating terminal" })
