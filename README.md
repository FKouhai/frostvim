# Frostvim

A Nix flake providing a customized Neovim configuration built with [Nixvim](https://github.com/nix-community/nixvim).

## Installation

### Using as a Flake Input

Add this flake to your Nix configuration:

```nix
{
  inputs = {
    frostvim.url = "github:FKouhai/frostvim/main";  # or GitHub URL when published
  };

  outputs = { nixpkgs, frostvim, ... }: {
    # Use the package
    packages.default = frostvim.packages.${system}.default;
  };
}
```

### Running Directly

Run Neovim with this configuration:

```bash
nix run .#default
```

Or from a remote repository (once published):

```bash
nix run github:FKouhai/frostvim/main
```

### Installing System-wide (NixOS)

Add to your `configuration.nix`:

```nix
{ inputs, ... }:

{
  environment.systemPackages = [
    inputs.frostvim.packages.${system}.default
  ];
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
