{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    git_helpers.enable = lib.mkEnableOption "Enable git nixvim plugins module";
  };

  config = lib.mkMerge [
    { git_helpers.enable = lib.mkDefault true; }
    (lib.mkIf config.git_helpers.enable {
      plugins = {
        coverage = {
          enable = true;
          settings = {
            command = true;
            lang = {
              go = {
                coverage_file.__raw = "vim.fn.getcwd() .. ' /coverage.out '";
              };
            };
          };
        };

        gitsigns = {
          enable = true;
          settings = {
            current_line_blame = true;
            current_line_blame_opts = {
              virt_text = true;
              virt_text_pos = "eol";
            };
            signcolumn = true;
            watch_gitdir = {
              follow_files = true;
            };
          };
        };

        lazygit = {
          enable = true;
        };

        fugitive.enable = true;
        diffview.enable = true;

        git-conflict = {
          enable = true;
          settings = {
            default_commands = true;
            default_mappings = {
              both = "b";
              next = "nn";
              none = "0";
              ours = "o";
              prev = "p";
              theirs = "t";
            };
            disable_diagnostics = false;
            highlights = {
              current = "DiffText";
              incoming = "DiffAdd";
            };
            list_opener = "copen";
          };
        };
      };

      keymaps = [
        {
          action = ":GitBlameOpenCommitURL<CR>";
          key = "<leader>gb";
          options = {
            silent = true;
            noremap = true;
            desc = "Open git blame URL";
          };
        }
        {
          action = ":DiffviewOpen<CR>";
          key = "<leader>ldo";
          options = {
            silent = true;
            noremap = true;
            desc = "Diffview open";
          };
        }
        {
          action = ":DiffviewClose<CR>";
          key = "<leader>ldp";
          options = {
            silent = true;
            noremap = true;
            desc = "Diffview close";
          };
        }
      ];
    })
  ];
}
