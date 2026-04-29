{
  lib,
  config,
  ...
}:
{
  options = {
    web-devicons.enable = lib.mkEnableOption "Enable web-devicons nixvim plugin module";
  };

  config = lib.mkMerge [
    { web-devicons.enable = lib.mkDefault true; }
    (lib.mkIf config.web-devicons.enable {
      plugins.web-devicons.enable = true;
    })
  ];
}
