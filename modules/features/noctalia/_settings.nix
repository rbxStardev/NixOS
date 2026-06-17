# ==============================================================================
# FILE: modules/features/noctalia/_settings.nix
# ==============================================================================
# Declarative Noctalia v5 settings mapping.
# This maps directly to the ~/.config/noctalia/config.toml schema.
# ==============================================================================
{config, ...}: {
  programs.noctalia.settings = {
    # ----------------------------------------------------------------------
    # Shell & UI Globals
    # ----------------------------------------------------------------------
    shell = {
      avatar_path = toString config.assets.avatarPicture;
      font_family = "JetBrainsMono Nerd Font";
      password_style = "random";
      polkit_agent = true;
      settings_show_advanced = true;

      clipboard_enabled = true;
      clipboard_history_max_entries = 50;
      corner_radius_scale = 0;

      panel = {
        control_center_placement = "floating";
      };

      shadow = {
        direction = "down_right";
      };

      screenshot = {
        save_to_file = true;
        directory = ""; # Defaults to ~/Pictures
        copy_to_clipboard = true;
        freeze_screen = true;
        pipe_to_command = true;
        pipe_command = "satty -f -";
      };
    };

    # ----------------------------------------------------------------------
    # Theme & Colors
    # ----------------------------------------------------------------------
    theme = {
      mode = "dark";
      source = "custom";
      custom_palette = "gruvbox";
    };

    # ----------------------------------------------------------------------
    # Bars
    # ----------------------------------------------------------------------
    bar = {
      # Defines the creation order of the bars
      order = ["main"];

      main = {
        radius = 0;

        position = "left";
        background_opacity = 0.76;
        thickness = 32;
        margin_edge = 0;
        margin_ends = 0;

        capsule = true;
        capsule_radius = 0.0;
        capsule_border = "primary";
        border = "primary";

        start = ["launcher" "clock" "date" "active_window"];
        center = ["audio_visualizer" "workspaces" "audio_visualizer"];
        end = ["tray" "notifications" "battery" "volume" "brightness" "control-center"];
      };
    };

    # ----------------------------------------------------------------------
    # Specific Widget Settings
    # ----------------------------------------------------------------------
    widget = {
      # Time widget (vertical layout)
      clock = {
        vertical_format = "{:%H}\\n{:%M}";
      };

      # Date widget (vertical layout, showing day on top of month)
      date = {
        type = "clock";
        vertical_format = "{:%d}\\n{:%m}";
        tooltip_format = "{:%A, %B %d, %Y}";
      };

      battery = {
        display_mode = "graphic";
        hide_when_plugged = true;
        show_label = false;
      };

      brightness = {
        show_label = false;
      };

      launcher = {
        glyph = "rocket";
      };

      tray = {
        drawer = true;
      };

      volume = {
        show_label = false;
      };
    };

    # ----------------------------------------------------------------------
    # Wallpaper & Backdrop
    # ----------------------------------------------------------------------
    wallpaper = {
      enabled = true;
      directory = toString config.assets.wallpaperDir;
      directory_light = toString config.assets.wallpaperDir;
      directory_dark = toString config.assets.wallpaperDir;
      transition = ["honeycomb" "stripes"];
      fill_mode = "crop";
    };

    # ----------------------------------------------------------------------
    # Hooks
    # ----------------------------------------------------------------------
    hooks = {
      started = "noctalia msg wallpaper-random";
    };

    # ----------------------------------------------------------------------
    # Dock
    # ----------------------------------------------------------------------
    dock = {
      enabled = true;
      auto_hide = true;
      reserve_space = false;
      position = "bottom";
      icon_size = 32;
      radius = 0;
    };

    # ----------------------------------------------------------------------
    # Calendar & Location
    # ----------------------------------------------------------------------
    calendar = {
      enabled = true;
    };

    location = {
      auto_locate = true;
    };

    # ----------------------------------------------------------------------
    # Audio
    # ----------------------------------------------------------------------
    audio = {
      enable_sounds = true;
      notification_sound = toString config.assets.notificationSound;
      sound_volume = 1;
    };

    # ----------------------------------------------------------------------
    # Idle & Lock Behaviors
    # ----------------------------------------------------------------------
    idle = {
      # Delay before actions run, showing a fade overlay
      pre_action_fade_seconds = 2.0;

      behavior = {
        lock = {
          enabled = true;
          timeout = 600;
          command = "noctalia:session lock";
        };
        screen_off = {
          enabled = true;
          timeout = 660;
          command = "noctalia:dpms-off";
          resume_command = "noctalia:dpms-on";
        };
      };
    };

    # ----------------------------------------------------------------------
    # Keybinds (Internal Shell Modifiers)
    # ----------------------------------------------------------------------
    keybinds = {
      validate = ["Return"];
      cancel = ["Escape"];
      up = ["Up"];
      down = ["Down"];
      left = ["Left"];
      right = ["Right"];
    };

    # ----------------------------------------------------------------------
    # Widgets
    # ----------------------------------------------------------------------
    desktop_widgets = {
      enabled = false;
    };

    lockscreen_widgets = {
      enabled = true;
      schema_version = 2;
      widget_order = [
        "lockscreen-login-box@eDP-1"
        "lockscreen-widget-0000000000000001"
        "lockscreen-widget-0000000000000002"
        "lockscreen-widget-0000000000000003"
        "lockscreen-widget-0000000000000004"
        "lockscreen-widget-0000000000000005"
      ];
      grid = {
        cell_size = 8;
        major_interval = 4;
        visible = true;
      };
      widget = {
        "lockscreen-login-box@eDP-1" = {
          type = "login_box";
          output = "eDP-1";
          cx = 960.0;
          cy = 957.0;
          box_height = 0.0;
          box_width = 0.0;
          rotation = 0.0;
        };
        "lockscreen-widget-0000000000000001" = {
          type = "clock";
          output = "eDP-1";
          cx = 968.0;
          cy = 204.0;
          box_height = 88.0;
          box_width = 184.0;
          rotation = 0.0;
          settings = {
            background_radius = 0.0;
          };
        };
        "lockscreen-widget-0000000000000002" = {
          type = "label";
          output = "eDP-1";
          cx = 1060.0;
          cy = 312.0;
          box_height = 128.0;
          box_width = 368.0;
          rotation = 0.0;
          settings = {
            background_radius = 0.0;
            description = "";
            title = "Welcome back!";
          };
        };
        "lockscreen-widget-0000000000000003" = {
          type = "weather";
          output = "eDP-1";
          cx = 959.861328125;
          cy = 873.216796875;
          box_height = 89.56640625;
          box_width = 520.26171875;
          rotation = 0.0;
          settings = {
            background_color = "surface_variant";
            background_radius = 0.0;
          };
        };
        "lockscreen-widget-0000000000000004" = {
          type = "sticker";
          output = "eDP-1";
          cx = 768.0;
          cy = 268.0;
          box_height = 216.0;
          box_width = 216.0;
          rotation = 0.0;
          settings = {
            background_radius = 0.0;
            image_path = toString config.assets.avatarPicture;
            opacity = 1.0;
          };
        };
        "lockscreen-widget-0000000000000005" = {
          type = "audio_visualizer";
          output = "eDP-1";
          cx = 1152.0;
          cy = 204.0;
          box_height = 88.0;
          box_width = 184.0;
          rotation = 0.0;
          settings = {
            aspect_ratio = 2.5;
            background_radius = 0.0;
            bands = 32;
            show_when_idle = true;
          };
        };
      };
    };
  };
}
