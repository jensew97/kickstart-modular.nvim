-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  See `:help wincmd` for a list of all window commands
-- Tmux navigation for navigating between vim and tmux panes
vim.keymap.set('n', '<C-h>', '<cmd> TmuxNavigateLeft<CR>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<cmd> TmuxNavigateRight<CR>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<cmd> TmuxNavigateDown<CR>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<cmd> TmuxNavigateUp<CR>', { desc = 'Move focus to the upper window' })

vim.keymap.set('v', '<S-j>', ":m '>+1<CR>gv=gv", { desc = 'Move highlighted lines up' })
vim.keymap.set('v', '<S-k>', ":m '<-2<CR>gv=gv", { desc = 'Move highlighted lines down' })

vim.keymap.set('n', '<C-s>', '<cmd>w<CR>', { desc = 'File Save' })

vim.keymap.set('n', '<S-j>', 'mzJ`z"', { desc = 'Copy line below to the end of current' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Keep cursor centered when moving page up' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Keep cursor centered when moving page down' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Center while moving search' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Center while moving prev search' })

vim.keymap.set('x', 'p', '"_dP', { desc = "Don't overwrite clipboard when pasting" })

vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set(
  'n',
  '<leader>æ',
  "<cmd>!clang-format-mr --style=file --fallback-style=none -i $(git ls-files | grep -E '\\.(cpp|h|c|proto)$' | tr '\\n' ' '); qmlformat-mr --normalize --inplace --newline unix --force `git ls-files | grep -E '\\.qml$'` <CR>",
  { desc = 'Format with clang-format-mr and qmlformat-mr' }
)

vim.keymap.set('v', '<leader>/', "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { desc = 'Comment Toggle' })

-- Neotree
vim.keymap.set('n', '<C-n>', '<cmd>Neotree toggle<CR>', { desc = 'Neotree Toggle window' })

-- Clangd
vim.keymap.set('n', '<F4>', '<cmd> ClangdSwitchSourceHeader<CR>', { desc = 'Switch header file (cpp/h)' })

-- Zenmode
vim.keymap.set('n', '<leader>z', '<cmd> ZenMode<CR>', { desc = 'Toggle [Z]enmode' })

-- Undotree
vim.keymap.set('n', '<leader>u', '<cmd> UndotreeToggle <CR>', { desc = 'Toggle undotree' })

-- Neogit
vim.keymap.set('n', '<leader>gs', '<cmd> Neogit kind=split<CR>', { desc = 'Neogit toggle' })

-- Leap
vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap-forward)')
vim.keymap.set({ 'n', 'x', 'o' }, 'S', '<Plug>(leap-backward)')
vim.keymap.set({ 'n', 'x', 'o' }, 'gs', '<Plug>(leap-from-window)')

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.cmd 'autocmd User TelescopePreviewerLoaded setlocal number'
-- TODO: fix this and remove line above
-- vim.api.nvim_create_autocmd('User', {
--  desc = 'Telescope preview linenumber',
--  group = vim.api.nvim_create_augroup('telescope-preview-linenumber', { clear = true }),
--  callback = function()
--    vim.opt_local.number = true
--  end,
-- })

vim.api.nvim_create_user_command('DiagnosticToggle', function()
  local config = vim.diagnostic.config
  local vt = config().virtual_text
  config {
    virtual_text = not vt,
    underline = not vt,
    signs = not vt,
  }
end, { desc = 'toggle diagnostic' })
