# ==============================================================================
# FILE: modules/hosts/machine/hardware-configuration.nix
# ==============================================================================
# Auto-generated and customized hardware configuration file. Defines the raw
# block devices, filesystems, swap spaces, and early boot modules needed
# to mount the root system properly.
# ==============================================================================
{
  flake.nixosModules.hostMachineHardware = {
    config,
    lib,
    modulesPath,
    ...
  }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    # Early boot hardware modules necessary to access storage devices
    boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "usbhid" "usb_storage" "sd_mod"];
    boot.initrd.kernelModules = [];

    # Kernel modules required for CPU virtualization
    boot.kernelModules = ["kvm-amd"];
    boot.extraModulePackages = [];

    # Primary Root Filesystem
    fileSystems."/" = {
      device = "/dev/disk/by-uuid/4003e236-2866-4b37-a01d-6240f9bec37d";
      fsType = "ext4";
    };

    # UEFI Boot Partition
    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/8C57-7A85";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };

    # Swap space for hibernation and memory overflow
    swapDevices = [
      {device = "/dev/disk/by-uuid/fa6d28cf-b07a-4bd9-9577-21fbc204b926";}
    ];

    # Explicitly set the host platform architecture
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

    # Enable proprietary AMD microcode updates if firmware redistribution is allowed
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
