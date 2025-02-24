return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('neo-tree').setup {
      close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
      filesystem = {
        follow_current_file = {
          enabled = false, -- This will find and focus the file in the active buffer every time
          --               -- the current file is changed while the tree is open.
          -- leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
      },
      event_handlers = {{
          event = "neo_tree_buffer_enter",
          handler = function(arg)
            vim.cmd [[
              setlocal relativenumber
            ]]
          end,
        }},
      window = {
        width = 143, -- Work setup
        -- width = 60, -- Home setup
      },
      default_component_configs = {
        file_size = {
          enabled = false;
        },
        last_modified = {
          enabled = false;
        },
        type = {
          enabled = false;
        },
        modified = {
          enabled = false
        },
        git_status = {
          enabled = false
        },
      }
    }
  end,
}
-- EOP
