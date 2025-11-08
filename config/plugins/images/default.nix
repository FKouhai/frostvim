{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    image.enable = lib.mkEnableOption "Enable image nixvim plugin module";
  };

  config = lib.mkIf config.image.enable {
    plugins.image = {
      enable = true;
      settings = {
        backend = "kitty";
      };
    };
  };
}
