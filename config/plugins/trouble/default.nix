{
  lib,
  config,
  ...
}:
{
  options = {
    trouble.enable = lib.mkEnableOption "Enable trouble nixvim plugin module";
  };

  config = lib.mkMerge [
    { trouble.enable = lib.mkDefault true; }
    (lib.mkIf config.trouble.enable {
      plugins.trouble = {
        enable = true;
      };

      keymaps = [
        {
          action = ":Trouble diagnostics toggle<CR>";
          key = "<leader>xx";
          options = {
            silent = true;
            noremap = true;
            desc = "Toggle trouble diagnostics Mapping";
          };
        }
        {
          action = ":Trouble qflist toggle<CR>";
          key = "<leader>xQ";
          options = {
            silent = true;
            noremap = true;
            desc = "Quick fix list using trouble";
          };
        }
        {
          action = ":Trouble loclist toggle<CR>";
          key = "<leader>xL";
          options = {
            silent = true;
            noremap = true;
            desc = "Location list";
          };
        }
        {
          action = ":Trouble diagnostics toggle filter.buf=0<CR>";
          key = "<leader>xl";
          options = {
            silent = true;
            noremap = true;
            desc = "Location list";
          };
        }
      ];
    })
  ];
}
