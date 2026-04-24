{
  lib,
  config,
  ...
}:
{
  options = {
    trouble.enable = lib.mkEnableOption "Enable trouble nixvim plugin module";
  };

  config = lib.mkMerge [
    { trouble.enable = lib.mkDefault true; }
    (lib.mkIf config.trouble.enable {
      plugins.trouble = {
        enable = true;
      };
    })
  ];
}
