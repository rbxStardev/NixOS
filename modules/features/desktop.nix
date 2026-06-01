{self, ...}: {
  flake.nixosModules.desktop = {
    pkgs,
    config,
    ...
  }: let
    selfpkgs = self.packages."${pkgs.stdenv.hostPlatform.system}";
  in {
    imports = [
      self.nixosModules.gtk

      self.nixosModules.pipewire
      self.nixosModules.firefox
      self.nixosModules.chromium
      self.nixosModules.hyprland
      self.nixosModules.rmpc
    ];

    environment.systemPackages = [
      selfpkgs.terminal
      selfpkgs.noctalia-shell

      pkgs.mpv
      pkgs.qimgv
      pkgs.audacity
      pkgs.libreoffice

      pkgs.pavucontrol
      pkgs.blueman
    ];

    hjem.users.${config.preferences.user.name}.files = let
      yazi-gruvbox = pkgs.fetchFromGitHub {
        owner = "bennyyip";
        repo = "gruvbox-dark.yazi";
        rev = "91fdfa70f6d593934e62aba1e449f4ec3d3ccc90";
        hash = "sha256-RWqyAdETD/EkDVGcnBPiMcw1mSd78Aayky9yoxSsry4=";
      };
    in {
      ".config/xdg-desktop-portal-termfilechooser/config".text = ''
        [filechooser]
        cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
        default_dir=$HOME/Downloads
        create_help_file=1
        env=TERMCMD='alacritty --title filechooser -e'
        env=PATH="$PATH:/run/current-system/sw/bin"
        open_mode=suggested
        save_mode=last
      '';

      # removed: inode/directory=thunar.desktop;
      # add back later on here vvv
      ".config/mimeapps.list".text = ''
        [Default Applications]
        image/png=qimgv.desktop;
        image/jpeg=qimgv.desktop;
        application/pdf=firefox.desktop;
        application/vnd.openxmlformats-officedocument.wordprocessingml.document=firefox.desktop;
        audio/x-vorbis+ogg=audacity.desktop;
        x-scheme-handler/http=firefox.desktop;
        x-scheme-handler/https=firefox.desktop;
        x-scheme-handler/discord=vesktop.desktop;
        x-scheme-handler/tg=org.telegram.desktop.desktop;
      '';

      ".config/yazi/flavors/gruvbox-dark.yazi".source = yazi-gruvbox;
      ".config/yazi/theme.toml".text = ''
        [flavor]
        use = "gruvbox-dark"
      '';
    };

    services.blueman.enable = true;

    environment.sessionVariables = {
      QT_QPA_PLATFORMTHEME = "qt6ct";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_IM_MODULE = "fcitx";
      GDK_BACKEND = "wayland,x11";
      XMODIFIERS = "@im=fcitx";
    };

    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      ubuntu-sans
      cm_unicode
      corefonts
      unifont
    ];

    fonts.fontconfig.defaultFonts = {
      serif = ["Ubuntu Sans"];
      sansSerif = ["Ubuntu Sans"];
      monospace = ["JetBrainsMono Nerd Font"];
    };

    time.timeZone = "America/Bahia";
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "pt_BR.UTF-8";
      LC_IDENTIFICATION = "pt_BR.UTF-8";
      LC_MEASUREMENT = "pt_BR.UTF-8";
      LC_MONETARY = "pt_BR.UTF-8";
      LC_NAME = "pt_BR.UTF-8";
      LC_NUMERIC = "pt_BR.UTF-8";
      LC_PAPER = "pt_BR.UTF-8";
      LC_TELEPHONE = "pt_BR.UTF-8";
      LC_TIME = "pt_BR.UTF-8";
    };

    console.keyMap = "br-abnt2";

    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = with pkgs; [fcitx5-gtk];
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
