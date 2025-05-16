return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- sd'   - [S]urround [D]elete [']quotes
      -- sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()
      require('mini.git').setup()

      -- Use only HEAD name as summary string
      local format_summary = function(data)
        -- Utilize buffer-local table summary
        local summary = vim.b[data.buf].minigit_summary
        vim.b[data.buf].minigit_summary_string = summary.head_name or ''
      end

      local au_opts = { pattern = 'MiniGitUpdated', callback = format_summary }
      vim.api.nvim_create_autocmd('User', au_opts)
    end,
  },
}
