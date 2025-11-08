{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    dashboard.enable = lib.mkEnableOption "Enable dashboard nixvim plugin module";
  };
  config = lib.mkIf config.dashboard.enable {
    plugins.dashboard = {
      enable = true;
      settings = {
        change_to_vcs_root = true;
        config = {
          footer = [
            "FrostVim Dashboard"
          ];
          header = [
            "                                               "
            "            ▗▄▄▄       ▗▄▄▄▄    ▄▄▄▖           "
            "            ▜███▙       ▜███▙  ▟███▛           "
            "             ▜███▙       ▜███▙▟███▛            "
            "              ▜███▙       ▜██████▛             "
            "       ▟█████████████████▙ ▜████▛     ▟▙       "
            "      ▟███████████████████▙ ▜███▙    ▟██▙      "
            "             ▄▄▄▄▖           ▜███▙  ▟███▛      "
            "            ▟███▛             ▜██▛ ▟███▛       "
            "           ▟███▛               ▜▛ ▟███▛        "
            "  ▟███████████▛                  ▟██████████▙  "
            "  ▜██████████▛                  ▟███████████▛  "
            "        ▟███▛ ▟▙               ▟███▛           "
            "       ▟███▛ ▟██▙             ▟███▛            "
            "      ▟███▛  ▜███▙           ▝▀▀▀▀             "
            "      ▜██▛    ▜███▙ ▜██████████████████▛       "
            "       ▜▛     ▟████▙ ▜████████████████▛        "
            "             ▟██████▙       ▜███▙              "
            "            ▟███▛▜███▙       ▜███▙             "
            "           ▟███▛  ▜███▙       ▜███▙            "
            "           ▝▀▀▀    ▀▀▀▀▘       ▀▀▀▘            "
            "                                               "
          ];
          mru = {
            limit = 20;
          };
          project = {
            enable = false;
          };
          shortcut = [
            {
              action = {
                __raw = "function(path) Snacks.picker.files() end";
              };
              desc = "Files";
              group = "Label";
              icon = " ";
              icon_hl = "@variable";
              key = "f";
            }
            {
              action = {
                __raw = "function(path) Snacks.picker.files({ cwd = '~/.local/share/applications' }) end";
              };
              desc = " Apps";
              group = "DiagnosticHint";
              key = "a";
            }
            {
              action = {
                __raw = "function(path) Snacks.picker.files({ cwd = '~/.config' }) end";
              };
              desc = " dotfiles";
              group = "Number";
              key = "d";
            }
          ];
          week_header = {
            enable = false;
          };
        };
        theme = "hyper";
      };
    };
  };
}
