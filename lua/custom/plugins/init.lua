-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    cmd = {
      "TmuxNavigateLeft",
      "TmuxnavigateRight",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
    },
  },
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      delete_to_trash = true,
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        -- Disable built-in keymaps due to overlapping with other keymaps
        ["<C-s>"] = false,
        ["<C-h>"] = false,
        ["<C-l>"] = false,
      },
    },
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
  },
  {
    "rshkarin/mason-nvim-lint",
    event = "VeryLazy",
    dependencies = { "nvim-lint" },
    config = function()
      require("mason-nvim-lint").setup()
    end,
  },
  {
    "zapling/mason-conform.nvim",
    event = "VeryLazy",
    dependencies = { "conform.nvim" },
    config = function()
      require("mason-conform").setup {
        -- List of formatters to ignore during install
        ignore_install = {},
      }
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
  --  {
  --    "github/copilot.vim",
  --    event = "VeryLazy",
  --    config = function()
  --      vim.g.copilot_no_tab_map = true
  --      vim.g.copilot_enabled = false
  --    end,
  --  },
}
