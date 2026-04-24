{
  config,
  lib,
  ...
}:
{
  options = {
    blink.enable = lib.mkEnableOption "Enable blink-cmp as completion engine (mutually exclusive with cmp)";
  };

  config = lib.mkMerge [
    { blink.enable = lib.mkDefault false; }
    (lib.mkIf config.blink.enable {
      # Disable cmp when blink is active.
      # Priority 900 overrides cmp's lib.mkDefault (1000) but yields to an
      # explicit user assignment (priority 100), so power users can still
      # force both if they know what they're doing.
      cmp.enable = lib.mkOverride 900 false;

      plugins = {
        blink-cmp = {
          enable = true;
          lazyLoad.enable = false;
          settings = {
            appearance = {
              # "mono" for Nerd Font Mono variants, "normal" for regular Nerd Font
              nerd_font_variant = "mono";
            };

            completion = {
              accept.auto_brackets.enabled = true;
              documentation = {
                auto_show = true;
                auto_show_delay_ms = 200;
              };
              ghost_text.enabled = true;
            };

            keymap.preset = "default";
            signature.enabled = true;

            # Use neovim's built-in snippet engine (vim.snippet, available since 0.10)
            snippets = {
              expand.__raw = "function(snippet) vim.snippet.expand(snippet) end";
              active.__raw = "function(filter) return vim.snippet.active(filter) end";
              jump.__raw = "function(direction) vim.snippet.jump(direction) end";
            };

            sources = {
              default = [
                "lsp"
                "path"
                "snippets"
                "buffer"
                "spell"
                "dictionary"
              ];
              providers = {
                # blink-cmp-spell: vim's built-in spellcheck as a completion source
                spell = {
                  module = "blink-cmp-spell";
                  name = "Spell";
                  score_offset = 20;
                  opts = { };
                };
                # blink-cmp-words: dictionary word completion
                dictionary = {
                  name = "blink-cmp-words";
                  module = "blink-cmp-words.dictionary";
                  opts = {
                    dictionary_search_threshold = 3;
                    score_offset = 0;
                  };
                };
              };
            };
          };
        };

        # Compatibility shim so plugins that register nvim-cmp sources
        # (e.g. codecompanion) are picked up by blink automatically
        blink-compat = {
          enable = true;
          settings.impersonate_nvim_cmp = true;
        };

        # Auto-pairs with rainbow bracket highlighting
        blink-pairs = {
          enable = true;
          settings = {
            mappings.enabled = true;
            highlights = {
              enabled = true;
              cmdline = true;
            };
          };
        };

        # Rainbow indent guides
        blink-indent = {
          enable = true;
          settings = {
            static.highlights = [
              "BlinkIndentRed"
              "BlinkIndentOrange"
              "BlinkIndentYellow"
              "BlinkIndentGreen"
              "BlinkIndentViolet"
              "BlinkIndentCyan"
            ];
            scope.underline.enable = true;
          };
        };

        # Sources are configured above through blink-cmp's sources.providers
        blink-cmp-spell.enable = true;
        blink-cmp-words.enable = true;
      };
    })
  ];
}
