{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    opencode.enable = lib.mkEnableOption "Enable opencode nixvim plugin module";
  };

  config = lib.mkMerge [
    { opencode.enable = lib.mkDefault true; }
    (lib.mkIf config.opencode.enable {
      plugins = {
        opencode = {
          enable = true;
          settings = {
            port = 9999;
          };
        };
      };

      keymaps = [
        {
          mode = [
            "n"
            "x"
          ];
          key = "<C-a>";
          action.__raw = ''function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode" }'';
        }
        {
          mode = [
            "n"
            "x"
          ];
          key = "<C-x>";
          action.__raw = ''function() require("opencode").select() end'';
        }
      ];
    })
  ];
}
