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
    ];

    boot = {
      kernelPackages = pkgs.linuxPackages_latest;

      loader.grub.enable = true;
      loader.grub.efiSupport = true;
      loader.grub.efiInstallAsRemovable = true;

      supportedFilesystems.ntfs = true;

      kernelParams = ["quiet"];
      kernelModules = ["rtw89_8852be" "k10temp" "cpuid" "v4l2loopback"];

      binfmt.emulatedSystems = ["aarch64-linux"];
    };

    boot.plymouth.enable = true;

    networking = {
      hostName = "machine";
      networkmanager.enable = true;
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
    ];

    xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
    xdg.portal.enable = true;

    hardware.graphics.enable = true;

    networking.firewall.enable = true;
    programs.appimage.enable = true;
    programs.appimage.binfmt = true;

    # ADD BACK LATER -> services.xserver.videoDrivers = ["nvidia"];
    # ADD BACK LATER -> boot.initrd.kernelModules = ["nvidia"];

    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-move-transition
      ];
    };

    system.stateVersion = "25.11";
  };
}
