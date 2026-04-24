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
    })
  ];
}
