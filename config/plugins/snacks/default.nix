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

  config = lib.mkIf config.snacks.enable {

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
  };
}
