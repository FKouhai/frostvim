{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    lint.enable = lib.mkEnableOption "Enable lint nixvim plugin module";
  };

  config = lib.mkMerge [
    { lint.enable = lib.mkDefault true; }
    (lib.mkIf config.lint.enable {
      extraPackages = [
        pkgs.hadolint
        pkgs.revive
        pkgs.tflint
      ];
      plugins = {
        lint = {
          enable = true;
          lintersByFt = {
            text = [ "value" ];
            dockerfile = [ "hadolint" ];
            terraform = [ "tflint" ];
            go = [ "revive" ];
          };
        };
      };
    })
  ];
}
