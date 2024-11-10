---@diagnostic disable: unused-local
local disable = true

if disable then
  return {}
end

return {

  --
  -- ipynb notebook_navigator
  {
    "GCBallesteros/NotebookNavigator.nvim",
    ft = "python",
    keys = {
      { "[h", "<cmd>lua require('notebook-navigator').move_cell('u')<cr>" },
      { "]h", "<cmd>lua require('notebook-navigator').move_cell('d')<cr>" },
      { "<localleader>n", "<cmd>lua require('notebook-navigator').run_cell()<cr>" },
      { "<localleader>j", "<cmd>lua require('notebook-navigator').run_and_move()<cr>" },
    },
    dependencies = {
      "GCBallesteros/jupytext.nvim",
      "echasnovski/mini.ai",
      "echasnovski/mini.comment",
      "anuvyklack/hydra.nvim",
      -- "akinsho/toggleterm.nvim", -- alternative repl provider
      {
        "Vigemus/iron.nvim", -- repl provider
      },
    },
    config = function()
      local _ok, plug = pcall(require, "notebook-navigator")
      if _ok then
        plug.setup({ activate_hydra_keys = "<leader>n" })
      end
    end,
  },

  --
  --
  {
    "echasnovski/mini.hipatterns",
    -- event = "VeryLazy",
    dependencies = { "GCBallesteros/NotebookNavigator.nvim" },
    opts = function(_, opts)
      local plug = require("notebook-navigator")
      opts = vim.tbl_deep_extend("force", opts, {
        highlighters = { cells = plug.minihipatterns_spec },
      })
      return opts
    end,
  },
  {
    "echasnovski/mini.ai",
    -- event = "VeryLazy",
    dependencies = { "GCBallesteros/NotebookNavigator.nvim" },
    opts = function(_, opts)
      local plug = require("notebook-navigator")
      -- https://github.com/GCBallesteros/NotebookNavigator.nvim?tab=readme-ov-file#yankingdeleting-cells
      -- vah to select the full cell in visual mode.
      opts = vim.tbl_deep_extend("force", opts, {
        custom_textobjects = { h = plug.miniai_spec },
      })
      return opts
    end,
  },

  --
  {
    --#region
    "Vigemus/iron.nvim",
    config = function(_, opts)
      local iron = require("iron.core")

      iron.setup({
        config = {
          -- Whether a repl should be discarded or not
          scratch_repl = true,
          -- Your repl definitions come here
          repl_definition = {
            sh = {
              -- Can be a table or a function that
              -- returns a table (see below)
              command = { "zsh" },
            },
            python = {
              -- command = { "python3" }, -- or { "ipython", "--no-autoindent" }
              command = { "ipython", "--no-autoindent" },
              format = require("iron.fts.common").bracketed_paste_python,
            },
          },
          -- How the repl window will be displayed
          -- See below for more information
          repl_open_cmd = require("iron.view").bottom(40),
        },
        -- Iron doesn't set keymaps by default anymore.
        -- You can set them here or manually add keymaps to the functions in iron.core
        keymaps = {
          send_motion = "<space>sc",
          visual_send = "<space>sc",
          send_file = "<space>sf",
          send_line = "<space>sl",
          send_paragraph = "<space>sp",
          send_until_cursor = "<space>su",
          send_mark = "<space>sm",
          mark_motion = "<space>mc",
          mark_visual = "<space>mc",
          remove_mark = "<space>md",
          cr = "<space>s<cr>",
          interrupt = "<space>s<space>",
          exit = "<space>sq",
          clear = "<space>cl",
        },
        -- If the highlight is on, you can change how it looks
        -- For the available options, check nvim_set_hl
        highlight = {
          italic = true,
        },
        ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
      })

      -- iron also has a list of commands, see :h iron-commands for all available commands
      vim.keymap.set("n", "<space>rs", "<cmd>IronRepl<cr>")
      vim.keymap.set("n", "<space>rr", "<cmd>IronRestart<cr>")
      vim.keymap.set("n", "<space>rf", "<cmd>IronFocus<cr>")
      vim.keymap.set("n", "<space>rh", "<cmd>IronHide<cr>")
    end,
  },
}
