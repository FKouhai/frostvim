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

  config = lib.mkIf config.quicker.enable {
    plugins.quicker = {
      enable = true;
    };
  };
}
