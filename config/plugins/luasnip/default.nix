{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    luasnip.enable = lib.mkEnableOption "Enable luasnip nixvim plugin module";
  };

  config = lib.mkIf config.luasnip.enable {
    plugins.luasnip = {
      enable = true;
      fromVscode = [
        {
          lazyLoad = true;
          paths = "${pkgs.vimPlugins.friendly-snippets}";
        }
      ];
      settings = {
        enable_autosnippets = true;
        exit_roots = false;
        link_roots = true;
        keep_roots = true;
      };
    };
  };
}
