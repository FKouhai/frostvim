{
  self,
  lib,
  pkgs,
  inputs,
  config,
  ...
}:
{
  imports = [
    ./keymaps.nix
    ./plugins/blink
    ./plugins/clipboard-image
    ./plugins/cmp
    ./plugins/code_companion
    ./plugins/dashboard
    ./plugins/git
    ./plugins/harpoon
    ./plugins/images
    ./plugins/lint
    ./plugins/lsp
    ./plugins/lualine
    ./plugins/luasnip
    ./plugins/lzn
    ./plugins/markdown-preview
    ./plugins/oil
    ./plugins/opencode
    ./plugins/presence
    ./plugins/snacks
    ./plugins/telekasten
    ./plugins/telescope
    ./plugins/toggleterm
    ./plugins/tree-sitter
    ./plugins/trouble
    ./plugins/which-key
    # colorschemes
    ./colorschemes/kanagawa
    ./vimopts.nix
  ];

  config = {
    blink.enable = lib.mkDefault false;
    clipboard-image.enable = lib.mkDefault true;
    cmp.enable = lib.mkDefault true;

    dashboard.enable = lib.mkDefault true;
    git_helpers.enable = lib.mkDefault true;
    harpoon.enable = lib.mkDefault true;
    image.enable = lib.mkDefault true;
    lint.enable = lib.mkDefault true;
    lsp.enable = lib.mkDefault true;
    lualine.enable = lib.mkDefault true;
    luasnip.enable = lib.mkDefault true;
    markdown-preview.enable = lib.mkDefault true;
    oil.enable = lib.mkDefault true;
    opencode.enable = lib.mkDefault true;
    snacks.enable = lib.mkDefault true;
    lzn.enable = lib.mkDefault true;
    presence.enable = lib.mkDefault true;
    sitter.enable = lib.mkDefault true;
    telekasten.enable = lib.mkDefault true;
    telescope.enable = lib.mkDefault false;
    toggleterm.enable = lib.mkDefault true;
    trouble.enable = lib.mkDefault true;
    which-key.enable = lib.mkDefault true;

    # basic nixvim config
    package = pkgs.neovim-unwrapped.overrideAttrs {
      version = "v0.12.0-dev";
      src = pkgs.fetchFromGitHub {
        owner = "neovim";
        repo = "neovim";
        rev = "cf347110c190944c1e59fc15751feebe9e77ccfc";
        hash = "sha256-4p9Xbvmn9FADg1eG4JEY7RBAkXZbaGlSzdBkgOv9aG8=";
      };
    };
    luaLoader.enable = false;

    extraConfigLua = "require('go').setup()";

    extraPlugins = with pkgs.vimPlugins; [
      plenary-nvim
      go-nvim
      nvim-treesitter.withAllGrammars
    ];

    plugins = {
      web-devicons = {
        enable = true;
      };

      timerly.enable = true;
      noice.enable = true;

      mini = {
        enable = true;

        modules = {
          animate = {
            cursor = {
              enable = true;
            };
            scroll = {
              enable = true;
            };
            resize = {
              enable = true;
            };
            open = {
              enable = true;
            };
            close = {
              enable = true;
            };
          };
        };
      };
    };

    colorschemes = {
      kanagawa.enable = lib.mkDefault true;
    };
  };
}
