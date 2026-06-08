# ==============================================================================
# FILE: modules/features/desktop.nix
# ==============================================================================
# Acts as the master profile for the graphical environment. It aggregates all
# desktop-related modules, sets global environment variables for Wayland/Qt,
# handles MIME types, and installs GUI utilities.
# ==============================================================================
{self, ...}: {
  flake.nixosModules.desktop = {
    pkgs,
    lib,
    config,
    ...
  }: let
    inherit (lib) mkEnableOption mkIf mkDefault;
    cfg = config.features.desktop;
    selfpkgs = self.packages."${pkgs.stdenv.hostPlatform.system}";
  in {
    options.features.desktop = {
      enable = mkEnableOption "Wayland desktop baseline and UI applications";
    };

    # Imports MUST be at the top-level to ensure options are evaluated properly
    imports = [
      self.nixosModules.gtk
      self.nixosModules.pipewire
      self.nixosModules.firefox
      self.nixosModules.chromium
      self.nixosModules.discord
      self.nixosModules.gaming
      self.nixosModules.hyprland
      self.nixosModules.locale
      self.nixosModules.fonts
    ];

    config = mkIf cfg.enable {
      # Automatically enable the required underlying features if desktop is enabled
      features = {
        gtk.enable = mkDefault true;
        pipewire.enable = mkDefault true;
        fonts.enable = mkDefault true;
        locale.enable = mkDefault true;
        gaming.enable = mkDefault true;
        chromium.enable = mkDefault true;
        firefox.enable = mkDefault true;
        discord.enable = mkDefault true;
      };

      environment.systemPackages = [
        selfpkgs.terminal
        selfpkgs.noctalia-shell
        pkgs.chafa
        pkgs.alsa-utils
        pkgs.mpv
        pkgs.qimgv
        pkgs.audacity
        pkgs.libreoffice
        pkgs.pavucontrol
        pkgs.blueman
        pkgs.mpd-discord-rpc
      ];

      # File association and default application routing
      xdg.mime = {
        enable = true;
        defaultApplications = {
          "image/png" = "qimgv.desktop";
          "image/jpeg" = "qimgv.desktop";
          "application/pdf" = "firefox.desktop";
          "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "firefox.desktop";
          "audio/x-vorbis+ogg" = "audacity.desktop";
          "x-scheme-handler/http" = "firefox.desktop";
          "x-scheme-handler/https" = "firefox.desktop";
          "x-scheme-handler/discord" = "vesktop.desktop";
          "x-scheme-handler/tg" = "org.telegram.desktop.desktop";
        };
      };

      services.blueman.enable = true;
      services.upower.enable = true;
      security.polkit.enable = true;

      # Fallback environment variables
      environment.sessionVariables = {
        QT_QPA_PLATFORMTHEME = "qt6ct";
        QT_QPA_PLATFORM = "wayland;xcb";
        QT_IM_MODULE = "fcitx";
        GDK_BACKEND = "wayland,x11";
        GTK_USE_PORTAL = "1";
        XMODIFIERS = "@im=fcitx";
      };

      hardware = {
        enableAllFirmware = true;
        bluetooth.enable = true;
        bluetooth.powerOnBoot = true;
        graphics = {
          enable = true;
          enable32Bit = true;
        };
      };
    };
  };
}
