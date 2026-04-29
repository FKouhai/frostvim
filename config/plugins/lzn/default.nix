{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    lzn.enable = lib.mkEnableOption "Enable lzn nixvim plugin module";
  };

  config = lib.mkMerge [
    { lzn.enable = lib.mkDefault true; }
    (lib.mkIf config.lzn.enable {
      plugins.lz-n = {
        enable = true;
      };
    })
  ];
}
