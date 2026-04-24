{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    go.enable = lib.mkEnableOption "Enable go nixvim plugin module";
  };

  config = lib.mkMerge [
    { go.enable = lib.mkDefault true; }
    (lib.mkIf config.go.enable {
      extraConfigLua = "require('go').setup()";
      extraPlugins = with pkgs.vimPlugins; [
        plenary-nvim
        go-nvim
      ];
    })
  ];
}
