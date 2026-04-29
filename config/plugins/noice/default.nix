{
  lib,
  config,
  ...
}:
{
  options = {
    noice.enable = lib.mkEnableOption "Enable noice nixvim plugin module";
  };

  config = lib.mkMerge [
    { noice.enable = lib.mkDefault true; }
    (lib.mkIf config.noice.enable {
      plugins.noice.enable = true;
    })
  ];
}
