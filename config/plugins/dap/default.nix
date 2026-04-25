{
  lib,
  config,
  options,
  ...
}:
{
  options = {
    dap.enable = lib.mkEnableOption "Enable DAP (Debug Adapter Protocol) module";
  };

  config = lib.mkMerge [
    { dap.enable = lib.mkDefault true; }
    (lib.mkIf (config.dap.enable && (options ? cmp) && config.cmp.enable) {
      plugins.cmp-dap.enable = true;
      extraConfigLua = ''
        require("cmp").setup.filetype({ "dap-repl", "dapwatches" }, {
          sources = require("cmp").config.sources({
            { name = "dap" },
          }),
        })
      '';
    })
    (lib.mkIf config.dap.enable {
      plugins = {
        dap.enable = true;
        dap-go = {
          enable = true;
          settings.dap_configurations = [
            {
              type = "go";
              name = "Debug trigo";
              request = "launch";
              program.__raw = ''"''${workspaceFolder}"'';
              env.CGO_CFLAGS = "-U_FORTIFY_SOURCE";
            }
          ];
        };

        dap-ui = {
          enable = true;
          settings = {
            icons = {
              expanded = "▾";
              collapsed = "▸";
              current_frame = "";
            };
            controls = {
              enabled = true;
              # Host the controls toolbar in the repl element
              element = "repl";
            };
          };
        };

        # Inline variable values as virtual text while paused
        nvim-dap-virtual-text.enable = true;
      };

      extraConfigLua = ''
        -- Auto-open / auto-close dap-ui with session lifecycle
        local dap, dapui = require("dap"), require("dapui")

        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close()
        end

        -- Breakpoint signs using diagnostic highlight groups so they match the theme
        vim.fn.sign_define("DapBreakpoint",          { text = "", texthl = "DiagnosticError" })
        vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticWarn"  })
        vim.fn.sign_define("DapLogPoint",            { text = "", texthl = "DiagnosticInfo"  })
        vim.fn.sign_define("DapStopped",             { text = "", texthl = "DiagnosticOk", linehl = "DapStoppedLine" })
        vim.fn.sign_define("DapBreakpointRejected",  { text = "", texthl = "DiagnosticWarn"  })
      '';

      keymaps = [
        {
          key = "<leader>dc";
          action.__raw = "function() require('dap').continue() end";
          options = {
            desc = "Debug: Continue / Start";
            silent = true;
            noremap = true;
          };
        }
        {
          key = "<leader>dl";
          action.__raw = "function() require('dap').run_last() end";
          options = {
            desc = "Debug: Run last";
            silent = true;
            noremap = true;
          };
        }
        {
          key = "<leader>dt";
          action.__raw = "function() require('dap').terminate() end";
          options = {
            desc = "Debug: Terminate";
            silent = true;
            noremap = true;
          };
        }

        {
          key = "<leader>do";
          action.__raw = "function() require('dap').step_over() end";
          options = {
            desc = "Debug: Step over";
            silent = true;
            noremap = true;
          };
        }
        {
          key = "<leader>di";
          action.__raw = "function() require('dap').step_into() end";
          options = {
            desc = "Debug: Step into";
            silent = true;
            noremap = true;
          };
        }
        {
          key = "<leader>dO";
          action.__raw = "function() require('dap').step_out() end";
          options = {
            desc = "Debug: Step out";
            silent = true;
            noremap = true;
          };
        }
        {
          key = "<leader>dC";
          action.__raw = "function() require('dap').run_to_cursor() end";
          options = {
            desc = "Debug: Run to cursor";
            silent = true;
            noremap = true;
          };
        }

        {
          key = "<leader>db";
          action.__raw = "function() require('dap').toggle_breakpoint() end";
          options = {
            desc = "Debug: Toggle breakpoint";
            silent = true;
            noremap = true;
          };
        }
        {
          key = "<leader>dB";
          action.__raw = "function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end";
          options = {
            desc = "Debug: Conditional breakpoint";
            silent = true;
            noremap = true;
          };
        }
        {
          key = "<leader>dL";
          action.__raw = "function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log message: ')) end";
          options = {
            desc = "Debug: Log point";
            silent = true;
            noremap = true;
          };
        }

        {
          key = "<leader>du";
          action.__raw = "function() require('dapui').toggle() end";
          options = {
            desc = "Debug: Toggle UI";
            silent = true;
            noremap = true;
          };
        }
        {
          key = "<leader>de";
          action.__raw = "function() require('dapui').eval() end";
          mode = [
            "n"
            "v"
          ];
          options = {
            desc = "Debug: Eval expression";
            silent = true;
            noremap = true;
          };
        }
        {
          key = "<leader>dr";
          action.__raw = "function() require('dap').repl.toggle() end";
          options = {
            desc = "Debug: Toggle REPL";
            silent = true;
            noremap = true;
          };
        }
      ];
    })
  ];
}
