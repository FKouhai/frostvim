# Frostvim

A Nix flake providing a customized Neovim configuration built with [Nixvim](https://github.com/nix-community/nixvim).

## Installation

### Running Directly

Run Neovim with this configuration:

```bash
nix run .#default
```

Or from the remote repository:

```bash
nix run github:FKouhai/frostvim/main
```

### Installing System-wide (NixOS)

Add to your `configuration.nix`:

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    frostvim = {
      url = "github:FKouhai/frostvim/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
outputs = { inputs, ... }:

{
  environment.systemPackages = [
    inputs.frostvim.packages.${system}.default
  ];
}
```

## Extending the Configuration

You can use Frostvim as a base configuration and extend it with your own plugins and settings by importing the NixVim modules:

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    frostvim = {
      url = "github:FKouhai/frostvim/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixvim, frostvim, ... }: {
    # Import the default module and extend it
    nixvimConfigurations.default = nixvim.lib.${system}.makeNixvimWithModule {
      inherit (frostvim.nixvimModules) default;
      # Override defaults or add custom plugins
      blink.enable = true;
      # Add a new plugin
      plugins = {
        todo-comments = {
          enable = true;
          settings = {
            signs = true;
            sign_priority = 8;
            keywords = {
              FIX = {
                icon = " ";
                color = "error";
                alt = [ "FIXME" "BUG" "FIXIT" "ISSUE" ];
              };
              TODO = { icon = " "; color = "info"; };
              HACK = { icon = " "; color = "warning"; };
              WARN = { icon = " "; color = "warning"; alt = [ "WARNING" "XXX" ]; };
              PERF = { icon = " "; alt = [ "OPTIM" "PERFORMANCE" "OPTIMIZE" ]; };
              NOTE = { icon = " "; color = "hint"; alt = [ "INFO" ]; };
              TEST = { icon = "⏲ "; color = "test"; alt = [ "TESTING" "PASSED" "FAILED" ]; };
            };
          };
        };
      };
     };
   };
 }
 ```

### Updating Keymaps

To update an existing keymap, you can override the entire keymaps list with your modified version. Note that this replaces all default keymaps:

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    frostvim = {
      url = "github:FKouhai/frostvim/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixvim, frostvim, ... }: {
    nixvimConfigurations.default = nixvim.lib.${system}.makeNixvimWithModule {
      inherit (frostvim.nixvimModules) default;
      # Override keymaps with custom ones
      keymaps = [
        # Keep or modify existing keymaps as needed
        {
          mode = "n";
          key = "<leader><leader>";
          action.__raw = "function() print('Custom smart picker') end";
          options = {
            silent = true;
            noremap = true;
            desc = "Custom smart picker";
          };
        }
        # Add other keymaps...
      ];
    };
  };
}
```

### Adding New Keymaps

To add new keymaps while keeping the defaults, concatenate the default keymaps with your new ones:

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    frostvim = {
      url = "github:FKouhai/frostvim/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixvim, frostvim, ... }: {
    nixvimConfigurations.default = nixvim.lib.${system}.makeNixvimWithModule {
      inherit (frostvim.nixvimModules) default;
      # Add new keymaps to the defaults
      keymaps = frostvim.nixvimModules.default.keymaps ++ [
        {
          mode = "n";
          key = "<leader>h";
          action = ":echo 'Hello World'<CR>";
          options = {
            silent = true;
            noremap = true;
            desc = "Say hello";
          };
        }
      ];
    };
  };
}
```

## Features

This configuration includes the following plugins:
- blink (disabled by default)
- clipboard-image
- cmp (code completion)
- code_companion
- dashboard
- git
- harpoon
- images
- lint
- lsp
- lualine (status line)
- luasnip (snippets)
- lzn
- markdown-preview
- oil (file explorer)
- opencode (includes snacks picker)
- presence
- telekasten (note-taking)
- telescope (disabled by default)
- toggleterm
- tree-sitter
- trouble (diagnostics)
- which-key
- web-devicons
- timerly
- noice
- mini (with animate module)
- kanagawa (colorscheme)
- plenary-nvim
- go-nvim
- nvim-treesitter (with all grammars)

## Development

### Building

```bash
nix build
```

### Running Tests

```bash
nix flake check
```

### Development Shell

Enter a development shell with pre-commit hooks:

```bash
nix develop
```

## Contributing

1. Fork the repository
2. Make your changes
3. Run `nix flake check` to ensure everything works
4. Submit a pull request
