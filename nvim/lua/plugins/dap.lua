return {
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
}
