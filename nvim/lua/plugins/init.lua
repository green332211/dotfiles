return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "stevearc/dressing.nvim",
    lazy = false,
    opts = {},
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  { "nvim-neotest/nvim-nio" },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
        "eslint_d",
        "clangd",
        "clang-format",
        "debugpy",
        "eslint-lsp",
        "js-debug-adapter",
        "typescript-language-server",
        "emmet-ls",
        "pyright",
        "isort",
        "black",
        "pylint",
        "eslint_d",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "htmldjango",
        "css",
        "typescript",
        "javascript",
        "python",
        "tsx",
        "c",
        "markdown",
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
      require "configs.lint"
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "nvim-neotest/neotest",
    event = "VeryLazy",
    config = function()
      require("neotest").setup {
        adapters = {
          require "neotest-jest" {
            jestCommand = "npm test --",
            jestConfigFile = "jest.config.ts",
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          },
        },
      }
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "haydenmeade/neotest-jest",
    },
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      local ok, dap = pcall(require, "dap")
      if not ok then
        return
      end

      -- Настройка адаптера для JavaScript/TypeScript/React
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "js-debug-adapter", -- Убедитесь, что js-debug-adapter установлен через Mason
          args = { "${port}" },
        },
      }

      -- Конфигурация для TypeScript
      dap.configurations.typescript = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          protocol = "inspector",
          runtimeExecutable = "node",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach to process",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
          sourceMaps = true,
        },
      }

      -- Конфигурация для JavaScript
      dap.configurations.javascript = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          protocol = "inspector",
          runtimeExecutable = "node",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach to process",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
          sourceMaps = true,
        },
      }

      -- Конфигурация для TypeScript React (.tsx)
      dap.configurations.typescriptreact = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file (React)",
          program = "${file}",
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          protocol = "inspector",
          runtimeExecutable = "node",
          -- Дополнительные настройки для React, если нужно
          resolveSourceMapLocations = {
            "${workspaceFolder}/**",
            "!**/node_modules/**",
          },
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach to process (React)",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          resolveSourceMapLocations = {
            "${workspaceFolder}/**",
            "!**/node_modules/**",
          },
        },
      }

      -- Конфигурация для JavaScript React (.jsx)
      dap.configurations.javascriptreact = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file (React)",
          program = "${file}",
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          protocol = "inspector",
          runtimeExecutable = "node",
          resolveSourceMapLocations = {
            "${workspaceFolder}/**",
            "!**/node_modules/**",
          },
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach to process (React)",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          resolveSourceMapLocations = {
            "${workspaceFolder}/**",
            "!**/node_modules/**",
          },
        },
      }

      -- Настройка Python (оставляем как есть)
      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch Python",
          program = "${file}",
          pythonPath = function()
            local venv_path = os.getenv "VIRTUAL_ENV"
            if venv_path then
              return venv_path .. "/bin/python"
            else
              return "/usr/bin/python"
            end
          end,
        },
      }
      dap.adapters.python = {
        type = "executable",
        command = function()
          local venv_path = os.getenv "VIRTUAL_ENV"
          if venv_path then
            return venv_path .. "/bin/python"
          else
            return os.getenv "HOME" .. "/path/to/venv/bin/python"
          end
        end,
        args = { "-m", "debugpy.adapter" },
      }
    end,
    dependencies = {
      "mxsdev/nvim-dap-vscode-js",
    },
  },
  -- {
  --   "mfussenegger/nvim-dap",
  --   config = function()
  --     local ok, dap = pcall(require, "dap")
  --     if not ok then
  --       return
  --     end
  --     dap.configurations.typescript = {
  --       {
  --         type = "node2",
  --         name = "node attach",
  --         request = "attach",
  --         program = "${file}",
  --         cwd = vim.fn.getcwd(),
  --         sourceMaps = true,
  --         protocol = "inspector",
  --       },
  --     }
  --     dap.adapters.node2 = {
  --       type = "executable",
  --       command = "node-debug2-adapter",
  --       args = {},
  --     }
  --     dap.configurations.python = {
  --       {
  --         type = "python",
  --         request = "launch",
  --         name = "Launch Python",
  --         program = "${file}",
  --         pythonPath = function()
  --           local venv_path = os.getenv "VIRTUAL_ENV"
  --           if venv_path then
  --             return venv_path .. "/bin/python"
  --           else
  --             return "/usr/bin/python"
  --           end
  --         end,
  --       },
  --     }
  --     dap.adapters.python = {
  --       type = "executable",
  --       command = function()
  --         local venv_path = os.getenv "VIRTUAL_ENV"
  --         if venv_path then
  --           return venv_path .. "/bin/python"
  --         else
  --           return os.getenv "HOME" .. "/path/to/venv/bin/python"
  --         end
  --       end,
  --       args = { "-m", "debugpy.adapter" },
  --     }
  --   end,
  --   dependencies = {
  --     "mxsdev/nvim-dap-vscode-js",
  --   },
  -- },
  {
    "rcarriga/nvim-dap-ui",
    config = function()
      require("dapui").setup()

      local dap, dapui = require "dap", require "dapui"

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open {}
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close {}
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close {}
      end
    end,
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function(_, opts)
      local venv_path = os.getenv "VIRTUAL_ENV"
      local path = venv_path and venv_path .. "/bin/python" or "/usr/bin/python"
      require("dap-python").setup(path)
    end,
  },
  {
    "folke/neodev.nvim",
    config = function()
      require("neodev").setup {
        library = { plugins = { "nvim-dap-ui" }, types = true },
      }
    end,
  },
  { "tpope/vim-fugitive" },
  { "rbong/vim-flog", dependencies = {
    "tpope/vim-fugitive",
  }, lazy = false },
  { "sindrets/diffview.nvim", lazy = false },
  {
    "ggandor/leap.nvim",
    lazy = false,
    config = function()
      require("leap").add_default_mappings(true)
    end,
  },
  {
    "kevinhwang91/nvim-bqf",
    lazy = false,
  },
  {
    "folke/trouble.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
    config = function()
      require("todo-comments").setup()
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
