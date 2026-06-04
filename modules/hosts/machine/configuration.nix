{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.machine = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.hostMachine
    ];
  };

  flake.nixosModules.hostMachine = {pkgs, ...}: {
    imports = [
      self.nixosModules.base
      self.nixosModules.general
      self.nixosModules.desktop

      self.nixosModules.powersave

      self.nixosModules.sddm-astronaut

      self.nixosModules.nvidia
      self.nixosModules.asus
    ];

    boot = {
      kernelPackages = pkgs.linuxPackages_latest;

      loader.limine.enable = true;
      loader.limine.efiSupport = true;
      loader.efi.canTouchEfiVariables = true;
      loader.timeout = 0;

      supportedFilesystems.ntfs = true;

      consoleLogLevel = 0;

      kernelParams = [
        "quiet"
        "splash"
        "rd.systemd.show_status=false"
        "rd.udev.log_level=3"
        "udev.log_priority=3"
        "amd_pstate=active"
        "vt.global_cursor_default=0"
      ];
      kernelModules = ["rtw89_8852be" "k10temp" "cpuid" "v4l2loopback" "tcp_bbr" "asus_wmi"];

      binfmt.emulatedSystems = ["aarch64-linux"];
    };

    boot.plymouth.enable = true;
    boot.initrd.systemd.enable = true;

    services.displayManager.sddm = {
      enable = true;
      astronaut = {
        enable = true;
        theme = "japanese_aesthetic";
      };
    };

    networking = {
      hostName = "machine";
      networkmanager = {
        enable = true;
        wifi.powersave = true;
      };
    };

    boot.kernel.sysctl = {
      "net.ipv4.tcp_congestion_control" = "bbr";

      "net.core.default_qdisc" = "fq";
    };

    virtualisation.libvirtd.enable = true;
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings = {
        dns_enabled = true;
      };
    };

    hardware.cpu.amd.updateMicrocode = true;

    services = {
      hardware.openrgb.enable = true;
      flatpak.enable = true;
      udisks2.enable = true;
      printing.enable = true;
    };

    environment.systemPackages = with pkgs; [
      winetricks
      glib

      qt6Packages.qt5compat
      qt6Packages.qtdeclarative
      qt6Packages.qtsvg
      qt6Packages.qtwayland
    ];

    environment.sessionVariables = {
      QML_IMPORT_PATH = ["/run/current-system/sw/lib/qt-6/qml"];
      QML2_IMPORT_PATH = ["/run/current-system/sw/lib/qt-6/qml"];
    };

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];

      config = {
        hyprland = {
          default = ["hyprland" "gtk"];
        };
        common = {
          default = ["gtk"];
        };
      };
    };

    hardware.graphics.enable = true;

    networking.firewall.enable = true;
    programs.appimage.enable = true;
    programs.appimage.binfmt = true;

    services.xserver.videoDrivers = ["nvidia"];
    services.xserver.enable = true;
    boot.initrd.kernelModules = ["nvidia"];

    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-move-transition
      ];
    };

    system.stateVersion = "26.05";
  };
}
