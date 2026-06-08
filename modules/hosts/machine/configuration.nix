# ==============================================================================
# FILE: modules/hosts/machine/configuration.nix
# ==============================================================================
# The master declaration of the 'machine' host. This file simply toggles on
# the modular features defined elsewhere in the flake and applies host-specific
# configurations such as networking, bootloader, and virtualization.
# ==============================================================================
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
      self.nixosModules.hostMachineHardware
    ];

    # ==========================================================================
    # Feature Flags
    # ==========================================================================
    features = {
      nix.enable = true;
      general.enable = true;
      locale.enable = true;
      powersave.enable = true;

      pipewire.enable = true;
      fonts.enable = true;
      desktop.enable = true;
      gtk.enable = true;

      gaming.enable = true;
      discord.enable = true;
      firefox.enable = true;
      chromium.enable = true;
    };

    hardware = {
      nvidia-gpu.enable = true;
      asus-rog.enable = true;
    };

    # ==========================================================================
    # Bootloader and Kernel
    # ==========================================================================
    boot = {
      kernelPackages = pkgs.linuxPackages_latest;

      # Limine Bootloader configuration
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

      plymouth.enable = true;
      initrd.systemd.enable = true;

      # Network throughput optimizations
      kernel.sysctl = {
        "net.ipv4.tcp_congestion_control" = "bbr";
        "net.core.default_qdisc" = "fq";
      };
    };

    # ==========================================================================
    # Display Manager
    # ==========================================================================
    services.displayManager.sddm = {
      enable = true;
      astronaut = {
        enable = true;
        theme = "japanese_aesthetic";
      };
    };

    # ==========================================================================
    # Networking & Virtualization
    # ==========================================================================
    networking = {
      hostName = "machine";
      networkmanager = {
        enable = true;
        wifi.powersave = true;
      };
      firewall.enable = true;
    };

    virtualisation.libvirtd.enable = true;
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings = {
        dns_enabled = true;
      };
    };

    # ==========================================================================
    # System Services and Hardware
    # ==========================================================================
    hardware.cpu.amd.updateMicrocode = true;

    services = {
      hardware.openrgb.enable = true;
      flatpak.enable = true;
      udisks2.enable = true;
      printing.enable = true;
      xserver.enable = true; # Underlying X11 server required by SDDM/XWayland
    };

    # ==========================================================================
    # Standalone Packages and Utilities
    # ==========================================================================
    environment.systemPackages = [
      pkgs.winetricks
      pkgs.glib
      pkgs.qt6Packages.qt5compat
      pkgs.qt6Packages.qtdeclarative
      pkgs.qt6Packages.qtsvg
      pkgs.qt6Packages.qtwayland
    ];

    environment.sessionVariables = {
      QML_IMPORT_PATH = ["/run/current-system/sw/lib/qt-6/qml"];
      QML2_IMPORT_PATH = ["/run/current-system/sw/lib/qt-6/qml"];
    };

    # ==========================================================================
    # Portals and AppImage Support
    # ==========================================================================
    xdg.portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
      config = {
        hyprland.default = ["hyprland" "gtk"];
        common.default = ["gtk"];
      };
    };

    programs.appimage = {
      enable = true;
      binfmt = true;
    };

    programs.obs-studio = {
      enable = true;
      plugins = [pkgs.obs-studio-plugins.obs-move-transition];
    };

    # DO NOT CHANGE. Matches the state version the system was originally installed on.
    system.stateVersion = "26.05";
  };
}
