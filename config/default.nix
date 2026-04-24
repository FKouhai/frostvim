{
  self,
  lib,
  pkgs,
  inputs,
  config,
  ...
}:
let
  # Auto-discover all subdirectory modules under a path, same pattern as
  # import-tree in the home-manager config — adding a new plugin folder is enough.
  importDirs =
    path:
    map (name: path + "/${name}") (
      builtins.attrNames (lib.filterAttrs (_: t: t == "directory") (builtins.readDir path))
    );
in
{
  imports =
    importDirs ./plugins
    ++ importDirs ./colorschemes
    ++ [ (import ./vimopts.nix { inherit lib pkgs; }) ];

  config = {
    package = pkgs.neovim-unwrapped;
    luaLoader.enable = false;
  };
}
