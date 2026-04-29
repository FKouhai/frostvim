{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    telekasten.enable = lib.mkEnableOption "Enable telekasten nixvim plugin module";
  };

  config = lib.mkMerge [
    { telekasten.enable = lib.mkDefault true; }
    (lib.mkIf config.telekasten.enable {
      plugins.telekasten = {
        enable = true;
        settings = {
          home = {
            __raw = "vim.fn.expand(\"~/vaults/personal/notes/\")";
          };
          image_subdir = {
            __raw = "vim.fn.expand(\"~/vaults/personal/assets/imgs\")";
          };
        };
      };

      keymaps = [
        {
          action = ":Telekasten panel<CR>";
          key = "<leader>zz";
          options = {
            silent = true;
            noremap = true;
            desc = "Open telekasten panel";
          };
        }
        {
          action = ":Telekasten find_notes<CR>";
          key = "<leader>zf";
          options = {
            silent = true;
            noremap = true;
            desc = "Open notes panel";
          };
        }
        {
          action = ":Telekasten search_notes<CR>";
          key = "<leader>zs";
          options = {
            silent = true;
            noremap = true;
            desc = "Open livegrep notes panel";
          };
        }
      ];
    })
  ];
}
