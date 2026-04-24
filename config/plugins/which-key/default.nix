{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    which-key.enable = lib.mkEnableOption "Enable which-key nixvim plugin module";
  };

  config = lib.mkMerge [
    { which-key.enable = lib.mkDefault true; }
    (lib.mkIf config.which-key.enable {
      plugins.which-key = {
        enable = true;
        settings = {
          preset = "helix";
        };
      };
    })
  ];
}
