-- python3 -m venv venv_molten
-- source ./venv_molten/bin/activate
-- pip install pynvim ipython jupytext jupyter_client jupyter ipykernel notebook
-- python -m ipykernel install --user --name venv_molten
-- -- hoac: ipython kernel install --user --name=venv_molten

local enabled = true

if enabled == false then
  return {}
end

return {
  -- ipynb molten
  {
    "benlubas/molten-nvim",
    dependencies = {
      "3rd/image.nvim",
    },
    tag = "v1.5.2", -- waiting for a stable version
    build = ":UpdateRemotePlugins",
    init = function()
      function MoltenInitPython()
        vim.cmd([[
            let py=has("win32")==1?"python":"python3"
            "":MoltenInit py
            if has("win32")
            :MoltenInit python
            else
            :MoltenInit python3
            endif
            :MoltenEvaluateArgument a=5
          ]])
      end

      vim.cmd([[
            :command MoltenInitPython lua MoltenInitPython()
          ]])
      -- vim.g.python3_host_prog = vim.fn.expand("$HOME") .. "/.virtualenvs/venv/bin/python3"
      -- vim.g.python3_host_prog = vim.fn.expand("$VIRTUAL_ENV") .. "/bin/python3"
      vim.g.python3_host_prog = vim.fn.has("win32") and "python" or "python3"
      vim.g.molten_image_provider = "none"
      -- vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_use_border_highlights = true
      -- add a few new things

      -- don't change the mappings (unless it's related to your bug)
      vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>")
      vim.keymap.set("n", "<localleader>e", ":MoltenEvaluateOperator<CR>")
      vim.keymap.set("n", "<localleader>rr", ":MoltenReevaluateCell<CR>")
      vim.keymap.set("v", "<localleader>r", ":<C-u>MoltenEvaluateVisual<CR>gv")
      vim.keymap.set("n", "<localleader>os", ":noautocmd MoltenEnterOutput<CR>")
      vim.keymap.set("n", "<localleader>oh", ":MoltenHideOutput<CR>")
      vim.keymap.set("n", "<localleader>md", ":MoltenDelete<CR>")
    end,
  },

  --
  -- 3rd/image.nvim
  {
    "3rd/image.nvim",
    enabled = false,
    opts = {
      backend = "kitty",
      integrations = {},
      max_width = 100,
      max_height = 12,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = true,
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    },
    version = "1.1.0", -- or comment out for latest
  },

  --
  -- ipynb notebook_navigator
  {
    "GCBallesteros/NotebookNavigator.nvim",
    ft = "python",
    keys = {
      { "[h", "<cmd>lua require('notebook-navigator').move_cell('u')<cr>" },
      { "]h", "<cmd>lua require('notebook-navigator').move_cell('d')<cr>" },
      { "<leader>X", "<cmd>lua require('notebook-navigator').run_cell()<cr>" },
      { "<leader>x", "<cmd>lua require('notebook-navigator').run_and_move()<cr>" },
    },
    dependencies = {
      "GCBallesteros/jupytext.nvim",
      "echasnovski/mini.ai",
      "echasnovski/mini.comment",
      "hkupty/iron.nvim", -- repl provider
      -- "akinsho/toggleterm.nvim", -- alternative repl provider
      "anuvyklack/hydra.nvim",
    },
    config = function()
      local nn_ok, nn = pcall(require, "notebook-navigator")
      if nn_ok then
        nn.setup({ activate_hydra_keys = "<leader>h" })
      end
    end,
  },

  --
  -- jupytext
  {
    "GCBallesteros/jupytext.nvim",
    -- event = "VeryLazy",
    config = function()
      require("jupytext").setup({
        style = "hydrogen",
      })
    end,
  },

  --
  --
  {
    "echasnovski/mini.hipatterns",
    -- event = "VeryLazy",
    dependencies = { "GCBallesteros/NotebookNavigator.nvim" },
    opts = function(_, opts)
      local nn = require("notebook-navigator")
      opts = vim.tbl_deep_extend("force", opts, {
        highlighters = { cells = nn.minihipatterns_spec },
      })
      return opts
    end,
  },
  {
    "echasnovski/mini.ai",
    -- event = "VeryLazy",
    dependencies = { "GCBallesteros/NotebookNavigator.nvim" },
    opts = function(_, opts)
      local nn = require("notebook-navigator")
      -- https://github.com/GCBallesteros/NotebookNavigator.nvim?tab=readme-ov-file#yankingdeleting-cells
      -- vah to select the full cell in visual mode.
      opts = vim.tbl_deep_extend("force", opts, {
        custom_textobjects = { h = nn.miniai_spec },
      })
      return opts
    end,
  },
}
