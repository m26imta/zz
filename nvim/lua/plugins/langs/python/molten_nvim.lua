return {
  --
  -- ipynb molten
  {
    "benlubas/molten-nvim",
    -- --Latest version
    -- version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    -- --OR waiting for a stable version
    version = "1.5.2", -- OK
    dependencies = {
      -- {
      --   "3rd/image.nvim",
      -- },
    },
    build = ":UpdateRemotePlugins",
    init = function()
      -- vim.g.python3_host_prog = vim.fn.expand("$VIRTUAL_ENV") .. "/bin/python3"
      -- vim.g.python3_host_prog = vim.fn.has("win32") and "python" or "python3"
      vim.g.python3_host_prog = vim.fn.has("win32") == 1 and "python" or vim.fn.expand("$VIRTUAL_ENV") .. "/bin/python3"
      vim.g.molten_image_provider = "none"
      -- vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_use_border_highlights = true
      -- add a few new things
      --
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
}
