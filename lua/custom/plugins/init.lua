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
    },
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require "lint"
      lint.linters_by_ft = {
        lua = { "luacheck" },
        haskell = { "hlint" },
        python = { "flake8" },
      }
      lint.linters.luacheck.args = {
        unpack(lint.linters.luacheck.args),
        "--globals",
        "love",
        "vim",
      }
      vim.api.nvim_create_autocmd(
        { "BufEnter", "BufWritePost", "InsertLeave" },
        {
          callback = function()
            lint.try_lint()
          end,
        }
      )
    end,
  },
  {
    "rshkarin/mason-nvim-lint",
    event = "VeryLazy",
    dependencies = { "nvim-lint" },
    config = function()
      local lint = package.loaded["lint"]
      -- List of linters to ignore during install
      local ignore_install = {}
      -- Helper function to find if value is in table.
      local function table_contains(table, value)
        for _, v in ipairs(table) do
          if v == value then
            return true
          end
        end
        return false
      end
      -- Build a list of linters to install minus the ignored list.
      local all_linters = {}
      for _, v in pairs(lint.linters_by_ft) do
        for _, linter in ipairs(v) do
          if not table_contains(ignore_install, linter) then
            table.insert(all_linters, linter)
          end
        end
      end
      require("mason-nvim-lint").setup {
        ensure_installed = all_linters,
        automatic_installation = false,
      }
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
    "github/copilot.vim",
    event = "VeryLazy",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_enabled = false
    end,
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
}
