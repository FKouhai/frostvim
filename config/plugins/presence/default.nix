{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    presence.enable = lib.mkEnableOption "Enable presence nixvim plugin module";
  };

  config = lib.mkMerge [
    { presence.enable = lib.mkDefault (!pkgs.stdenv.isDarwin); }
    (lib.mkIf config.presence.enable {
      plugins.cord = {
        enable = true;
        settings = {
          editor = {
            tooltip = "Neovim";
          };
          display = {
            theme = "default";
            flavor = "dark";
          };
          timestamp = {
            enabled = true;
            reset_on_idle = false;
            reset_on_change = false;
          };
          idle = {
            enabled = true;
            timeout = 300000;
            show_status = true;
            smart_idle = true;
          };
          text = {
            workspace.__raw = "function(opts) return 'In ' .. opts.workspace end";
            editing.__raw = "function(opts) return 'Editing ' .. opts.filename end";
            viewing.__raw = "function(opts) return 'Viewing ' .. opts.filename end";
            dashboard = "Home";
          };
        };
      };
    })
  ];
}
