-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal' },
  },
  config = function()
    require("neo-tree").setup({
      filesystem = {
        filtered_items = {
          visible = false,
          show_hidden_count = true,
          hide_dotfiles = false,
        },
        window = {
          mappings = {
            ['\\'] = 'close_window',
          },
        }
      }
    })
  end

}