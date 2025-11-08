{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    markdown-preview.enable = lib.mkEnableOption "Enable markdown-preview nixvim plugin module";
  };

  config = lib.mkIf config.markdown-preview.enable {
    plugins.markdown-preview = {
      enable = true;
      settings = {
        auto_close = 1;
        theme = "dark";
      };
    };
  };
}
