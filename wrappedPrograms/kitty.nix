# ==============================================================================
# FILE: wrappedPrograms/kitty.nix
# ==============================================================================
# Configures the Kitty terminal emulator using Lassulus' wrappers.
# ==============================================================================
{
  self,
  inputs,
  ...
}: {
  flake.wrappersModules.kitty = {
    config,
    lib,
    ...
  }: let
    colors = self.theme;
  in {
    options = {
      shell = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "Path to the default shell executable to run inside Kitty.";
      };
    };

    config = {
      settings.shell = lib.mkIf (config.shell != "") config.shell;

      settings = {
        # FONT
        font_family = "JetBrainsMono Nerd Font";
        italic_font = "JetBrainsMono Nerd Font Italic";
        bold_font = "JetBrainsMono Nerd Font Bold";
        bold_italic_font = "JetBrainsMono Nerd Font Bold Italic";
        font_size = 12;

        adjust_line_height = 4;
        adjust_column_width = 1;
        disable_ligatures = "never";

        # WINDOW BEHAVIOR
        window_padding_width = 14;
        enable_audio_bell = "no";
        remember_window_size = "no";
        placement_strategy = "center";
        hide_window_decorations = "titlebar-only";

        # PERFORMANCE
        repaint_delay = 10;
        input_delay = 1;
        sync_to_monitor = "yes";

        # SCROLLBACK
        scrollback_lines = 5000;
        scrollback_pager_history_size = 64;

        # MISC
        window_border_width = 0;
        cursor_shape = "block";
        cursor_blink_interval = "0.8";
        shell_integration = "enabled";

        # COLORS — Base
        foreground = colors.base05;
        background = colors.base00;
        background_opacity = "0.98";
        selection_foreground = colors.base06;
        selection_background = colors.base02;
        cursor = colors.base06;
        cursor_text_color = colors.base00;
        url_color = colors.base0D;
        active_border_color = colors.base0B;
        inactive_border_color = colors.base01;

        # COLORS — ANSI
        color0 = colors.base00;
        color8 = colors.base02;
        color1 = colors.base08;
        color9 = colors.base08;
        color2 = colors.base0B;
        color10 = colors.base0B;
        color3 = colors.base0A;
        color11 = colors.base0A;
        color4 = colors.base0D;
        color12 = colors.base0D;
        color5 = colors.base0E;
        color13 = colors.base0E;
        color6 = colors.base0C;
        color14 = colors.base0C;
        color7 = colors.base05;
        color15 = colors.base07;

        # KEYBINDINGS
        "map ctrl+shift+enter" = "new_tab";
        "map ctrl+shift+left" = "previous_tab";
        "map ctrl+shift+right" = "next_tab";
        "map ctrl+shift+w" = "close_tab";
      };
    };
  };

  # ----------------------------------------------------------------------------
  # 2. Empacotamento do pacote base
  # ----------------------------------------------------------------------------
  perSystem = {pkgs, ...}: {
    packages.kitty =
      (inputs.wrappers.wrapperModules.kitty.apply {
        inherit pkgs;
        imports = [self.wrappersModules.kitty];
      }).wrapper;
  };
}
