-- Disable netrw
-- vim.g.loaded_netrwPlugin = 1
-- vim.g.loaded_netrw = 1

local nvimtree_config = function()
  require("nvim-tree").setup({
    disable_netrw = true,
    hijack_cursor = true,
    hijack_netrw = false,
    update_cwd = true,
    view = {
      width = 30,
      side = "left",
    },
    git = {
      enable = true,
      ignore = true,
      timeout = 400,
    },
    actions = {
      open_file = {
        quit_on_open = false,
      },
    },

    -- https://github.com/nvim-tree/nvim-tree.lua/wiki/Archived#example
    on_attach = function(bufnr)
      local api = require("nvim-tree.api")

      local function opts(desc)
        return {
          desc = "nvim-tree: " .. desc,
          buffer = bufnr,
          noremap = true,
          silent = true,
          nowait = true,
        }
      end

      -- BEGIN_DEFAULT_ON_ATTACH
      api.config.mappings.default_on_attach(bufnr) -- just single-line setup

      -- You will need to insert "your code goes here" for any mappings with a custom action_cb
      vim.keymap.set("n", "A", api.tree.expand_all, opts("Expand All"))
      vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
      vim.keymap.set("n", "C", api.tree.change_root_to_node, opts("CD"))
      vim.keymap.set("n", "P", function()
        local node = api.tree.get_node_under_cursor()
        print(node.absolute_path)
      end, opts("Print Node Path"))

      vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
      vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))

      vim.keymap.set("n", "<C-s>", api.node.open.horizontal, opts("Open: Horizontal Split"))
      vim.keymap.set("n", "Z", api.node.run.system, opts("Run System"))
    end,
  })
end

return {
  {
    "nvim-tree/nvim-tree.lua",
    event = "VeryLazy",
    cmd = { "NvimTreeToggle", "NvimTreeFindFileToggle" },
    keys = {
      { "<leader>1", "<cmd>NvimTreeToggle<cr>", silent = true },
      { "<leader>da", "<cmd>cd %:h<cr><cmd>NvimTreeOpen<cr>", silent = true },
    },
    config = nvimtree_config,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
}
