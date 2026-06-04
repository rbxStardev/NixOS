{self, ...}: {
  flake.nixosModules.desktop = {
    pkgs,
    lib,
    ...
  }: let
    selfpkgs = self.packages."${pkgs.stdenv.hostPlatform.system}";
  in {
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

    environment.systemPackages = [
      selfpkgs.terminal
      pkgs.chafa
      selfpkgs.noctalia-shell

      pkgs.mpv
      pkgs.qimgv
      pkgs.audacity
      pkgs.libreoffice

      pkgs.pavucontrol
      pkgs.blueman

      pkgs.mpd-discord-rpc
    ];

    xdg.mime = {
      enable = true;
      defaultApplications = {
        #"inode/directory" = "thunar.desktop";
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

    environment.etc = {
      "xdg/xdg-desktop-portal-termfilechooser/config".text = ''
        [filechooser]
        cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
        default_dir=$HOME/Downloads
        create_help_file=1
        env=TERMCMD='${lib.getExe selfpkgs.terminal} --title filechooser -e'
        env=PATH="$PATH:${lib.makeBinPath [selfpkgs.yazi pkgs.file]}"
        open_mode=suggested
        save_mode=last
      '';
    };

    environment.sessionVariables = {
      QT_QPA_PLATFORMTHEME = "qt6ct";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_IM_MODULE = "fcitx";
      GDK_BACKEND = "wayland,x11";
      GTK_USE_PORTAL = "1";
      XMODIFIERS = "@im=fcitx";
    };

    services.upower.enable = true;

    security.polkit.enable = true;

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
}
