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
    ./plugins/images
    ./plugins/quicker
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
    ./plugins/tree-sitter
    ./plugins/trouble
    ./plugins/which-key
    # colorschemes
    ./colorschemes/kanagawa
    (import ./vimopts.nix { inherit lib pkgs; })
  ];

  config = {
    blink.enable = lib.mkDefault false;
    clipboard-image.enable = lib.mkDefault false;
    cmp.enable = lib.mkDefault true;

    dashboard.enable = lib.mkDefault true;
    git_helpers.enable = lib.mkDefault true;
    image.enable = lib.mkDefault true;
    lint.enable = lib.mkDefault true;
    lsp.enable = lib.mkDefault true;
    lualine.enable = lib.mkDefault true;
    luasnip.enable = lib.mkDefault true;
    markdown-preview.enable = lib.mkDefault true;
    oil.enable = lib.mkDefault true;
    opencode.enable = lib.mkDefault true;
    quicker.enable = lib.mkDefault true;
    snacks.enable = lib.mkDefault true;
    lzn.enable = lib.mkDefault true;
    presence.enable = if !pkgs.stdenv.isDarwin then lib.mkDefault true else lib.mkDefault false;
    sitter.enable = lib.mkDefault true;
    telekasten.enable = lib.mkDefault true;
    trouble.enable = lib.mkDefault true;
    which-key.enable = lib.mkDefault true;

    # basic nixvim config
    package = pkgs.neovim-unwrapped.overrideAttrs {
      version = "v0.12.0-dev";
      src = pkgs.fetchFromGitHub {
        owner = "neovim";
        repo = "neovim";
        rev = "03d6cf7aae4a72c7221a4fb8ebb14a7c8603ba18";
        hash = "sha256-RkQKSCqEsTxPc1i7RsDDbOCJObVdq7R9YJ94UrI1k8w=";
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
