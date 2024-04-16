return {
  { 'christoomey/vim-tmux-navigator' },

  {
    'folke/zen-mode.nvim',
    opts = {
      window = {
        width = 140,
      },
      plugins = {
        options = {
          laststatus = 3,
        },
      },
    },
  },

  { 'mbbill/undotree' },
}
