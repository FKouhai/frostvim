{
  lib,
  config,
  ...
}:
{
  options = {
    trouble.enable = lib.mkEnableOption "Enable trouble nixvim plugin module";
  };

  config = lib.mkIf config.trouble.enable {
    plugins.trouble = {
      enable = true;
    };
  };
}
