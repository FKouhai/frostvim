{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    snacks.enable = lib.mkEnableOption "Enable snacks nixvim plugin module";
  };

  config = lib.mkMerge [
    { snacks.enable = lib.mkDefault true; }
    (lib.mkIf config.snacks.enable {
      plugins = {
        snacks = {
          enable = true;
          settings = {
            input.enabled = true;
            terminal.enable = true;
            picker = {
              ui_select = true;
            };
          };
        };
      };

      keymaps = [
        {
          mode = "n";
          key = "<leader><leader>";
          action.__raw = "function() Snacks.picker.smart() end";
        }
        {
          mode = "n";
          key = "<leader>s";
          action.__raw = "function() Snacks.explorer() end";
        }
        {
          action.__raw = "function() Snacks.terminal.toggle() end";
          key = "<leader>tt";
          options = {
            silent = true;
            noremap = true;
            desc = "Open snacks terminal";
          };
        }
        {
          action.__raw = ''
            function()
              Snacks.terminal({"go", "run", "main.go"}, { cwd = os.getenv("PWD")})
            end
          '';
          key = "<leader>eg";
          options = {
            silent = true;
            noremap = true;
            desc = "go run main.go";
          };
        }
        {
          action.__raw = "function() Snacks.picker.lsp_definitions() end";
          key = "<leader>gd";
          options = {
            silent = true;
            noremap = true;
            desc = "Go to definition";
          };
        }
        {
          action.__raw = "function() Snacks.picker.lsp_implementations() end";
          key = "gI";
          options = {
            silent = true;
            noremap = true;
            desc = "Go to Implementation";
          };
        }
        {
          action.__raw = "function() Snacks.picker.lsp_type_definitions() end";
          key = "gy";
          options = {
            silent = true;
            noremap = true;
            desc = "Go to T[y]pe Definition";
          };
        }
        {
          action.__raw = "function() Snacks.picker.lsp_references() end";
          key = "<leader>gr";
          options = {
            silent = true;
            noremap = true;
            desc = "Go to references";
          };
        }
        {
          action.__raw = "function() Snacks.lazygit.open() end";
          key = "<leader>lg";
          options = {
            silent = true;
            noremap = true;
            desc = "open lazygit";
          };
        }
        {
          action.__raw = "function() Snacks.picker.grep() end";
          key = "<leader>fg";
          options = {
            silent = true;
            noremap = true;
            desc = "Search grep";
          };
        }
        {
          action.__raw = "function() Snacks.picker.buffers() end";
          key = "<leader>fb";
          options = {
            silent = true;
            noremap = true;
            desc = "Search buffers";
          };
        }
        {
          action.__raw = "function() Snacks.picker.lines() end";
          key = "<leader>b";
          options = {
            silent = true;
            noremap = true;
            desc = "Search current buffer";
          };
        }
        {
          action.__raw = "function() Snacks.picker.command_history() end";
          key = "<leader>fh";
          options = {
            silent = true;
            noremap = true;
            desc = "Search commands";
          };
        }
        {
          action.__raw = "function() Snacks.picker.files() end";
          key = "<leader>ff";
          options = {
            silent = true;
            noremap = true;
            desc = "Search files";
          };
        }
        {
          action.__raw = "function() Snacks.picker.commands() end";
          key = "<leader>fc";
          options = {
            silent = true;
            noremap = true;
            desc = "Search commands";
          };
        }
        {
          action.__raw = "function() Snacks.picker.diagnostics() end";
          key = "<leader>fd";
          options = {
            silent = true;
            noremap = true;
            desc = "Diagnostics";
          };
        }
        {
          action.__raw = "function() Snacks.picker.qflist() end";
          key = "<leader>ql";
          options = {
            silent = true;
            noremap = true;
            desc = "Quickfix list";
          };
        }
        {
          action.__raw = "function() Snacks.picker.undo() end";
          key = "<leader>fu";
          options = {
            silent = true;
            noremap = true;
            desc = "Undo tree";
          };
        }
        {
          action.__raw = "function() Snacks.picker.git_log() end";
          key = "<leader>fx";
          options = {
            silent = true;
            noremap = true;
            desc = "git commit";
          };
        }
        {
          action.__raw = "function() Snacks.picker.git_branches() end";
          key = "<leader>ft";
          options = {
            silent = true;
            noremap = true;
            desc = "git branches";
          };
        }
        {
          action.__raw = "function() Snacks.picker.git_status() end";
          key = "<leader>fst";
          options = {
            silent = true;
            noremap = true;
            desc = "git status";
          };
        }
      ];
    })
  ];
}
