{
  description = "frostvim nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixvim = {
      url = "github:nix-community/nixvim";
    };
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
    };
  };

  outputs =
    {
      nixpkgs,
      nixvim,
      flake-parts,
      pre-commit-hooks,
      ...
    }@inputs:
    let
      inherit (nixpkgs) lib;

      # Auto-discover all subdirectories under a path and return an attrset of
      # { name = import <path/name>; } — dropping any non-directory entries.
      # This means adding a new plugin folder automatically exposes it as a
      # nixvimModule without touching this file.
      autoModules =
        dir:
        builtins.mapAttrs (name: _: import (dir + "/${name}")) (
          lib.filterAttrs (_: t: t == "directory") (builtins.readDir dir)
        );
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "aarch64-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      flake = {
        nixvimModules =
          # Full frostvim configuration — backward compatible, this is what consumers import
          {
            default = import ./config;
          }
          # Individual plugin and colorscheme modules, auto-discovered from the filesystem.
          # Adding a new directory under config/plugins or config/colorschemes is enough.
          // autoModules ./config/plugins
          // autoModules ./config/colorschemes;
      };

      perSystem =
        {
          system,
          self',
          lib,
          ...
        }:
        let
          # TODO: remove once https://github.com/NixOS/nixpkgs/pull/512989 lands in nixos-unstable
          # nixvim's build.extraFiles derivation has only `name`, not `pname`, which the current
          # vim-utils.nix requires when processing the plugin list.
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              (
                _final: prev:
                let
                  addPname =
                    p:
                    if p ? pname then
                      p
                    else
                      p.overrideAttrs (old: {
                        pname = old.name or "unknown";
                      });
                  fixPluginSet =
                    pkgSet:
                    pkgSet
                    // {
                      start = map addPname (pkgSet.start or [ ]);
                      opt = map addPname (pkgSet.opt or [ ]);
                    };
                in
                {
                  vimUtils = prev.vimUtils // {
                    packDir = packages: prev.vimUtils.packDir (lib.mapAttrs (_: fixPluginSet) packages);
                  };
                }
              )
            ];
          };

          nixvimLib = nixvim.lib.${system};
          nixvim' = nixvim.legacyPackages.${system};
          nixvimModule = {
            inherit pkgs;
            module = import ./config;
            extraSpecialArgs = {
              inherit inputs;
            };
          };
          nvim = nixvim'.makeNixvimWithModule nixvimModule;
        in
        {
          checks = {
            default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
            pre-commit-check = pre-commit-hooks.lib.${system}.run {
              src = ./.;
              hooks = {
                statix.enable = true;
                nixfmt-rfc-style.enable = true;
              };
            };
          };

          formatter = pkgs.nixfmt-tree;

          packages = {
            default = nvim;
          };

          devShells = {
            default = pkgs.mkShell { inherit (self'.checks.pre-commit-check) shellHook; };
          };
        };
    };
}
