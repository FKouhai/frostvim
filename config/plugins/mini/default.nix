{
  lib,
  config,
  ...
}:
{
  options = {
    mini.enable = lib.mkEnableOption "Enable mini nixvim plugin module";
  };

  config = lib.mkMerge [
    { mini.enable = lib.mkDefault true; }
    (lib.mkIf config.mini.enable {
      plugins.mini = {
        enable = true;
        modules = {
          animate = {
            cursor.enable = true;
            scroll.enable = true;
            resize.enable = true;
            open.enable = true;
            close.enable = true;
          };
        };
      };
    })
  ];
}
