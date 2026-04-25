{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    oil.enable = lib.mkEnableOption "Enable oil nixvim plugin module";
  };

  config = lib.mkMerge [
    { oil.enable = lib.mkDefault true; }
    (lib.mkIf config.oil.enable {
      plugins.oil = {
        enable = true;
        settings = {
          win_options = {
            signcolumn = "yes:2";
          };
        };
      };
      plugins.oil-git-status = {
        enable = true;
      };

      keymaps = [
        {
          action = ":Oil<CR>";
          key = "-";
          options = {
            silent = true;
            noremap = true;
            desc = "Oil Mapping";
          };
        }
      ];
    })
  ];
}
