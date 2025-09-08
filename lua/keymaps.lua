-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-c>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.open_float, { desc = 'Show diagnostic Error messages' })
vim.keymap.set('n', '<leader>sq', vim.diagnostic.setloclist, { desc = '[S]how diagnostic [Q]uickfix list' })

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

--  not working
-- vim.keymap.set('i', '<C-l>', '<cmd> Tabout<CR>', { desc = 'Jump out of current bracket context' })
-- vim.keymap.set('i', '<C-h>', '<cmd> TaboutBack<CR>', { desc = 'Jump out of current bracket context' })

vim.keymap.set('v', '<S-j>', ":m '>+1<CR>gv=gv", { desc = 'Move highlighted lines up' })
vim.keymap.set('v', '<S-k>', ":m '<-2<CR>gv=gv", { desc = 'Move highlighted lines down' })

vim.keymap.set('n', '<C-s>', '<cmd>w<CR>', { desc = 'File Save' })

vim.keymap.set('n', '<S-j>', 'mzJ`z"', { desc = 'Copy line below to the end of current' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Keep cursor centered when moving page up' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Keep cursor centered when moving page down' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Center while moving search' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Center while moving prev search' })

vim.keymap.set('x', 'p', '"_dP', { desc = "Don't overwrite clipboard when pasting" })

vim.keymap.set('n', '<S-q><S-a>', '<cmd> :qa<CR>', { desc = "Quit vim (qa)" })

vim.keymap.set('n', '<leader>ra', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "[R]eplace [A]ll" })

vim.keymap.set(
  'n',
  '<leader>æ',
  "<cmd>!clang-format-mr --style=file --fallback-style=none -i $(git ls-files | grep -E '\\.(cpp|h|c|proto)$' | tr '\\n' ' '); qmlformat-mr --normalize --inplace --newline unix --force `git ls-files | grep -E '\\.qml$'` <CR>",
  { desc = 'Format with clang-format-mr and qmlformat-mr' }
)

vim.keymap.set('v', '<leader>/', "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
  { desc = 'Comment Toggle' })

-- Neotree
vim.keymap.set('n', '<leader>n', '<cmd>Neotree toggle filesystem<CR>', { desc = 'Neotree Toggle window' })
vim.keymap.set('n', '<leader>rf', '<cmd>Neotree filesystem reveal<CR>', { desc = 'Neotree [R]eveal Current [F]ile' })

-- Clangd
vim.keymap.set('n', '<F4>', '<cmd> LspClangdSwitchSourceHeader<CR>', { desc = 'Switch header file (cpp/h)' })

-- Zenmode
vim.keymap.set('n', '<leader>z', '<cmd> ZenMode<CR>', { desc = 'Toggle [Z]enmode' })

-- Undotree
vim.keymap.set('n', '<leader>u', '<cmd> UndotreeToggle <CR>', { desc = 'Toggle undotree' })

-- Neogit
vim.keymap.set('n', '<leader>lg', '<cmd> Neogit kind=floating<CR>', { desc = 'Neogit toggle' })

-- Lazygit
-- vim.keymap.set('n', '<leader>gs', '<cmd> LazyGit<CR>', { desc = 'Lazygit toggle' })

-- Leap
vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap-forward)')
vim.keymap.set({ 'n', 'x', 'o' }, 'S', '<Plug>(leap-backward)')
vim.keymap.set({ 'n', 'x', 'o' }, 'gs', '<Plug>(leap-from-window)')

-- Gitsigns
vim.keymap.set('n', '<leader>gb', '<cmd> Gitsigns blame_line <CR>', { desc = 'Blame current line' })
vim.keymap.set('n', '<leader>gB', '<cmd> Gitsigns blame <CR>', { desc = 'Blame current buffer' })
vim.keymap.set('n', '<leader>tb', '<cmd> Gitsigns toggle_current_line_blame <CR>', { desc = 'Toggle current line blame' })

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

-- Do not go to the start of the yanked buffer
local yank_cursor_pos = nil

vim.keymap.set({ 'n', 'x' }, 'y', function()
  yank_cursor_pos = vim.api.nvim_win_get_cursor(0)
  return 'y'
end, { expr = true, desc = 'Yank without moving cursor' })

vim.keymap.set('n', 'Y', function()
  yank_cursor_pos = vim.api.nvim_win_get_cursor(0)
  return 'y$'
end, { expr = true, desc = 'Yank line without moving cursor' })

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    if yank_cursor_pos ~= nil then
      vim.api.nvim_win_set_cursor(0, yank_cursor_pos)
      yank_cursor_pos = nil
    end
  end,
})
