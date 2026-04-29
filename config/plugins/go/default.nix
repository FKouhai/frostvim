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

      keymaps = [
        {
          action = ":GoIfErr<CR>";
          key = "<leader>ie";
          options = {
            silent = true;
            noremap = true;
            desc = "Golang iferr binding";
          };
        }
      ];
    })
  ];
}
