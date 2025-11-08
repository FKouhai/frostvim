{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.colorschemes.kanagawa.enable {
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
  };
}
