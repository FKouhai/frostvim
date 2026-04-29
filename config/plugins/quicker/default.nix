{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    quicker.enable = lib.mkEnableOption "Enable quicker nixvim plugin module";
  };

  config = lib.mkMerge [
    { quicker.enable = lib.mkDefault true; }
    (lib.mkIf config.quicker.enable {
      plugins.quicker = {
        enable = true;
      };

      keymaps = [
        {
          action.__raw = ''function() require("quicker").toggle() end'';
          key = "<C-q>";
          options = {
            silent = true;
            noremap = true;
            desc = "Quickfix list";
          };
        }
      ];
    })
  ];
}
