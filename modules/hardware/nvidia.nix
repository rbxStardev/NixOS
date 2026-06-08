# ==============================================================================
# FILE: modules/hardware/nvidia.nix
# ==============================================================================
# Configures NVIDIA proprietary drivers, power management, and early boot
# kernel modules to ensure proper initialization for Wayland/X11 compositors.
# ==============================================================================
{
  flake.nixosModules.nvidia = {
    config,
    lib,
    ...
  }: let
    inherit (lib) mkEnableOption mkIf;
    cfg = config.hardware.nvidia-gpu;
  in {
    options.hardware.nvidia-gpu = {
      enable = mkEnableOption "NVIDIA proprietary drivers and power management";
    };

    config = mkIf cfg.enable {
      # Inform Xorg and Wayland to use the proprietary Nvidia driver
      services.xserver.videoDrivers = ["nvidia"];

      # Load the Nvidia kernel module early to prevent race conditions during boot
      boot.initrd.kernelModules = ["nvidia"];

      hardware.nvidia = {
        # Fixes graphical corruption upon waking from suspend
        powerManagement.enable = true;

        # Use the proprietary, non-open-source driver for maximum compatibility
        open = false;

        # Install the nvidia-settings control panel
        nvidiaSettings = true;

        # Ensure the driver version matches the kernel's stable release
        package = config.boot.kernelPackages.nvidiaPackages.stable;
      };
    };
  };
}
