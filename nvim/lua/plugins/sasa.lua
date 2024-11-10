return {
  -- add colorscheme
  -- { "ellisonleao/gruvbox.nvim" },
  -- { "ayu-theme/ayu-vim" },
  { "EdenEast/nightfox.nvim" },

  -- Configure LazyVim to load colorscheme
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "carbonfox",
  --   },
  -- },

  -- bufferline
  {
    "akinsho/bufferline.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      { "moll/vim-bbye" },
    },
    -- merge with lazyvim's config
    -- change style to underline
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        options = {
          indicator = { style = "underline", icon = "▎" },
          buffer_close_icon = "",
          modified_icon = "●",
          close_icon = "",
        },
      })
    end,
  },

  -- Neotree
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        window = {
          width = 30,
          mappings = {
            -- Navigation with HJKL
            -- https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Tips#navigation-with-hjkl
            ["h"] = function(state)
              local node = state.tree:get_node()
              if node.type == "directory" and node:is_expanded() then
                require("neo-tree.sources.filesystem").toggle_directory(state, node)
              else
                require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
              end
            end,
            ["l"] = function(state)
              local node = state.tree:get_node()
              if node.type == "directory" then
                if not node:is_expanded() then
                  require("neo-tree.sources.filesystem").toggle_directory(state, node)
                elseif node:has_children() then
                  require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
                elseif not node:has_children() and require("neo-tree.utils").is_expandable(node) then
                  state.commands["toggle_node"](state) -- empty folder
                end
              elseif node.type == "file" then
              end
            end,
            -- Open file without losing sidebar focus
            -- https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Tips#open-file-without-losing-sidebar-focus
            ["<tab>"] = function(state)
              local node = state.tree:get_node()
              if require("neo-tree.utils").is_expandable(node) then
                state.commands["toggle_node"](state)
              else
                state.commands["open"](state)
                vim.cmd("Neotree reveal")
              end
            end,
          },
        },
      })
    end,
  },

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    -- change some options
    opts = function(_, opts)
      local actions = require("telescope.actions")
      return vim.tbl_deep_extend("force", opts, {
        defaults = {
          layout_strategy = "horizontal",
          layout_config = { prompt_position = "top" },
          sorting_strategy = "ascending",
          winblend = 0,
          mappings = {
            i = {
              ["<C-c>"] = actions.close,
            },
            n = {
              ["<esc>"] = actions.close,
              ["<C-c>"] = actions.close,
              ["q"] = actions.close,
            },
          },
        },
      })
    end,
  },

  -- Remove & change some keymaps that conflict with my vimrc
  -- LSP keymaps : <c-k> conflict as it is a <UP> key in my vimrc
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change <c-k> -> <c-f><c-k>
      keys[#keys + 1] = { "<c-k>", false, mode = "i" }
      keys[#keys + 1] = {
        "<c-f><c-k>",
        vim.lsp.buf.signature_help,
        mode = { "n", "i" },
        desc = "Signature Help",
        has = "signatureHelp",
      }
    end,
  },
  -- noice
  -- remove <c-f> as a reservation key in my vimrc, and remove also <c-b> because it is a pair with <c-f>
  {
    "folke/noice.nvim",
    -- remove <c-f>, <c-b>
    keys = function(_, keys)
      local keys_removal = { "<c-f>", "<c-b>" }
      local keys_index_removal = {}
      -- find the "<c-f>", "<c-b>" in keys table
      for index, value in ipairs(keys) do
        for _, v in ipairs(keys_removal) do
          if string.lower(value[1]) == v then
            table.insert(keys_index_removal, index)
          end
        end
      end
      -- sort index
      table.sort(keys_index_removal)
      -- remove the higher index first
      for i = #keys_index_removal, 1, -1 do
        table.remove(keys, keys_index_removal[i])
      end
      return keys
    end,
  },
}
