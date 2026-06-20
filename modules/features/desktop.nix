# ==============================================================================
# FILE: modules/features/desktop.nix
# ==============================================================================
# Acts as the master profile for the graphical environment.
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

    config = mkIf cfg.enable {
      features = {
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
        pkgs.chafa
        pkgs.alsa-utils
        pkgs.mpv
        pkgs.qimgv
        pkgs.audacity
        pkgs.libreoffice
        pkgs.pavucontrol
        pkgs.blueman
        pkgs.mpd-discord-rpc
        pkgs.xdg-terminal-exec
      ];

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

      environment.etc."xdg/xdg-terminals.list".text = ''
        foot.desktop
      '';

      environment.sessionVariables = {
        QT_QPA_PLATFORMTHEME = "qt6ct";
        QT_QPA_PLATFORM = "wayland;xcb";
        QT_IM_MODULE = "fcitx";
        GDK_BACKEND = "wayland,x11";
        GTK_USE_PORTAL = "1";
        XMODIFIERS = "@im=fcitx";
        TERMINAL = "foot";
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
