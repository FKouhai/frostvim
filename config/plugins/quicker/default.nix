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

  config = lib.mkMerge [
    { quicker.enable = lib.mkDefault true; }
    (lib.mkIf config.quicker.enable {
      plugins.quicker = {
        enable = true;
      };
    })
  ];
}
