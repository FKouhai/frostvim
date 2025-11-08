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

  config = lib.mkIf config.opencode.enable {

    plugins = {
      opencode = {
        enable = true;
        settings = {
          port = 9999;
        };
      };
    };
  };
}
