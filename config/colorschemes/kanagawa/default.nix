{
  config,
  lib,
  ...
}:
{
  config = lib.mkMerge [
    { colorschemes.kanagawa.enable = lib.mkDefault true; }
    (lib.mkIf config.colorschemes.kanagawa.enable {
      colorschemes.kanagawa = {
        settings = {
          transparent = true;
          theme = "dragon";
          terminalColors = true;
          commentStyle = {
            italic = true;
          };
        };
      };
    })
  ];
}
