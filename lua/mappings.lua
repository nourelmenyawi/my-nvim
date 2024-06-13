vim.keymap.set("n", "<leader>w", "<Cmd>write<Cr>")

vim.keymap.set("n", "<leader>q", "<Cmd>quit<Cr>")

vim.keymap.set("", "<leader><leader>ps", "<Cmd>Lazy sync<CR>",
  { desc = "update vim plugins" })

vim.keymap.set("", "±", "<Cmd>nohlsearch<CR>",
  { desc = "turn off search highlight" })

vim.keymap.set("n", "<leader><leader>dx", function()
  vim.diagnostic.disable()
  -- vim.diagnostic.reset(nil, 0)
end, { desc = "Disable diagnostics" })

vim.keymap.set("n", "<leader><leader>ds", function()
  vim.diagnostic.enable()
  -- vim.diagnostic.reset(nil, 0)
end, { desc = "Enable diagnostics (aka start)" })

vim.keymap.set("n", "<C-d>", "<C-d>zz",
  { desc = "scroll down and then center the cursorline" })

vim.keymap.set("n", "<C-u>", "<C-u>zz",
  { desc = "scroll up and then center the cursorline" })

vim.keymap.set("n", "zo", "zozz",
  { desc = "open fold and then center the cursorline" })

vim.keymap.set("n", "zr", "zrzz",
  { desc = "open fold and then center the cursorline" })

vim.keymap.set("n", "zR", "zRzz",
  { desc = "open all folds and then center the cursorline" })

vim.keymap.set("n", "zc", "zczz",
  { desc = "close fold and then center the cursorline" })

vim.keymap.set("n", "zm", "zmzz",
  { desc = "close fold and then center the cursorline" })

vim.keymap.set("n", "zM", "zMzz",
  { desc = "close all folds and then center the cursorline" })

vim.keymap.set("n", "n", "nzz",
  { desc = "move to the next search match and then center the cursorline" })

vim.keymap.set("n", "N", "Nzz",
  { desc = "move to the prev search match and then center the cursorline" })

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- Select all text in buffer
vim.keymap.set('n', '<leader>a', ':keepjumps normal! ggVG<cr>')

-- Navigator
vim.keymap.set({ 'n', 't' }, '<leader>h', '<CMD>NavigatorLeft<CR>')
vim.keymap.set({ 'n', 't' }, '<leader>l', '<CMD>NavigatorRight<CR>')
vim.keymap.set({ 'n', 't' }, '<leader>k', '<CMD>NavigatorUp<CR>')
vim.keymap.set({ 'n', 't' }, '<leader>j', '<CMD>NavigatorDown<CR>')
vim.keymap.set({ 'n', 't' }, '<leader>p', '<CMD>NavigatorPrevious<CR>')

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to previous/next
map('n', '<leader>,', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<leader>.', '<Cmd>BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<leader><', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<leader>>', '<Cmd>BufferMoveNext<CR>', opts)
-- Goto buffer in position...
map('n', '<leader-1>', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<leader-2>', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<leader-3>', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<leader-4>', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<leader-5>', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<leader-6>', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<leader-7>', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<leader-8>', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<leader-9>', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<leader-0>', '<Cmd>BufferLast<CR>', opts)
-- Pin/unpin buffer
map('n', '<leader>P>', '<Cmd>BufferPin<CR>', opts)
-- Close buffer
map('n', '<leader>c', '<Cmd>BufferClose<CR>', opts)
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- -- Magic buffer-picking mode
-- map('n', '<leader>', '<Cmd>BufferPick<CR>', opts)
-- -- Sort automatically by...
-- map('n', '<leader>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
-- map('n', '<leader>bn', '<Cmd>BufferOrderByName<CR>', opts)
-- map('n', '<leader>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
-- map('n', '<leader>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
-- map('n', '<leader>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)
--
-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used
