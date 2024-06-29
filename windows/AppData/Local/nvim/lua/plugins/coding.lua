return {

  { -- See `:help comment-nvim`
    'numToStr/Comment.nvim',
    opts = {
      toggler = {
          line = 'gcc',  -- Line-comment toggle keymap.
          block = 'gbc', -- Block-comment toggle keymap.
      },
      opleader = {       --[[ LHS of operator-pending mappings in NORMAL and VISUAL mode ]]
          line = 'gc',   -- Line-comment keymap.
          block = 'gb',  -- Block-comment keymap.
      },
      extra = {          --[[ LHS of extra mappings ]]
          above = 'gcO', -- Add comment on the line above.
          below = 'gco', -- Add comment on the line below.
          eol = 'gcA',   -- Add comment at the end of line.
      },
      -- Enable keybindings.
      -- NOTE: If given `false` then the plugin won't create any mappings.
      mappings = {
          basic = true,  -- Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`.
          extra = true,  -- Extra mapping; `gco`, `gcO`, `gcA`.
      },
    },
  },

  -- See `:help todo-comments.nvim.txt`.
  { 'folke/todo-comments.nvim', event = 'VimEnter', opts = { signs = false } },

  { -- See `:help `colorizer.lua`
    'norcalli/nvim-colorizer.lua',
    enabled = vim.opt.termguicolors,
    opts = { '*', '!txt', '!md' },
  },

}
