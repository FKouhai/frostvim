{
  config,
  lib,
  pkgs,
  ...
}:
# Requires pkgs.vimPlugins.kanoxo — apply kanoxo-colorscheme's overlays.default to nixpkgs.
{
  config = lib.mkMerge [
    {
      kanoxo.enable = lib.mkDefault true;
      kanoxo.variant = lib.mkDefault "wave";
    }
    (lib.mkIf config.kanoxo.enable (
      lib.mkMerge [
        {
          extraPlugins = [ pkgs.vimPlugins.kanoxo ];

          extraConfigLua = ''
            require("kanoxo").setup({
              variant         = "${config.kanoxo.variant}",
              transparent     = ${lib.boolToString config.kanoxo.transparent},
              terminal_colors = ${lib.boolToString config.kanoxo.terminalColors},
            })
            vim.cmd.colorscheme("kanoxo_${config.kanoxo.variant}")
          '';
        }
        # Lualine ships inside the kanoxo plugin (lua/lualine/themes/).
        # Plain assignment beats lualine's own mkDefault in plugins/lualine.
        (lib.mkIf (config ? lualine && config.lualine.enable) {
          plugins.lualine.settings.options.theme = "kanoxo_${config.kanoxo.variant}";
        })
      ]
    ))
  ];

  options.kanoxo = {
    enable = lib.mkEnableOption "kanoxo colorscheme";

    variant = lib.mkOption {
      type = lib.types.enum [
        "wave"
        "dragon"
      ];
      default = "wave";
      description = "wave — cool blue-purple. dragon — earthy neutrals.";
    };

    transparent = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    terminalColors = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };
}
