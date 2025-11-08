{
  config,
  lib,
  ...
}:
{
  options = {
    blink.enable = lib.mkEnableOption "Enable blink nixvim plugin module";
  };

  config = lib.mkIf config.blink.enable {
    plugins.blink-cmp = {
      enable = true;
      lazyLoad.enable = false;
      settings = {
        appearance = {
          nerd_font_variant = "normal";
          use_nvim_cmp_as_default = true;
        };
        completion = {
          accept = {
            auto_brackets = {
              enabled = true;
              semantic_token_resolution = {
                enabled = false;
              };
            };
          };
          documentation = {
            auto_show = true;
          };
        };
        keymap = {
          preset = "default";
        };
        sources = {
          default = [
            "lsp"
            "path"
            "buffer"
            "snippets"
          ];
        };
      };
    };
  };
}
