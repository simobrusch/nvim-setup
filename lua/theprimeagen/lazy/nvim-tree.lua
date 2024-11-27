return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({
      git = {
        enable = true,  -- Enable Git integration if supported
        ignore = true, -- Show .gitignore files
        timeout = 400,  -- Set a timeout for Git operations
      },
      view = {
        width = 30,
        side = "left",
        preserve_window_proportions = true,
        signcolumn = "yes",
      },
      renderer = {
        group_empty = true,
        highlight_git = true, -- Enable Git highlighting
        icons = {
          show = {
            git = true, -- Show Git status icons
            folder = true,
            file = true,
            folder_arrow = true,
          },
        },
      },
      actions = {
        open_file = {
          quit_on_open = false, -- Close tree when a file is opened
        },
      },
      diagnostics = {
        enable = true, -- Enable diagnostics integration
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")

        -- Default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- Custom Git mappings
        vim.keymap.set("n", "ga", function()
          local node = api.tree.get_node_under_cursor()
          if node and node.absolute_path then
            vim.cmd("!git add " .. vim.fn.fnameescape(node.absolute_path))
            print("Staged: " .. node.absolute_path)
          else
            print("No file selected")
          end
        end, { buffer = bufnr, noremap = true, silent = true })

        vim.keymap.set("n", "gs", function()
          local node = api.tree.get_node_under_cursor()
          if node and node.absolute_path then
            vim.cmd("!git status " .. vim.fn.fnameescape(node.absolute_path))
            print("Staged: " .. node.absolute_path)
          else
            print("No file selected")
          end
        end, { buffer = bufnr, noremap = true, silent = true })

        vim.keymap.set("n", "gu", function()
          local node = api.tree.get_node_under_cursor()
          if node and node.absolute_path then
            vim.cmd("!git restore --staged " .. vim.fn.fnameescape(node.absolute_path))
            print("Unstaged: " .. node.absolute_path)
          else
            print("No file selected")
          end
        end, { buffer = bufnr, noremap = true, silent = true })

        vim.keymap.set("n", "gc", function()
          vim.ui.input({ prompt = "Enter commit message: " }, function(message)
            if message and #message > 0 then
              vim.cmd("!git commit -m '" .. message .. "'")
              print("Committed changes with message: " .. message)
            else
              print("Commit aborted: No message provided.")
            end
          end)
        end, { buffer = bufnr, noremap = true, silent = true })

        vim.keymap.set("n", "gp", function()
          vim.cmd("!git push")
          print("Pushed changes to the remote repository.")
        end, { buffer = bufnr, noremap = true, silent = true })
      end,
    })
  end,
}
