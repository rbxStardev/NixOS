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
      self.nixosModules.hostMachineHardware

      self.nixosModules.base

      self.nixosModules.features
      self.nixosModules.hardware
    ];

    # ==========================================================================
    # Feature Flags
    # ==========================================================================
    features = {
      nix.enable = true;
      general.enable = true;
      powersave.enable = true;
      bootloader.enable = true;

      desktop.enable = true;
      sddm.enable = true;

      zerotierone.enable = true;
      virtualization.enable = false;
      appimage.enable = true;
    };

    hardware = {
      nvidia-gpu.enable = true;
      asus-rog.enable = true;
      amd-cpu.enable = true;
    };

    # ==========================================================================
    # Networking
    # ==========================================================================
    networking = {
      hostName = "machine";
      networkmanager = {
        enable = true;
        wifi.powersave = true;
      };
      firewall.enable = true;
    };

    programs.obs-studio = {
      enable = true;
      plugins = [pkgs.obs-studio-plugins.obs-move-transition];
    };

    system.stateVersion = "26.05";
  };
}
