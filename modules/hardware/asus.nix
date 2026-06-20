# ==============================================================================
# FILE: modules/hardware/asus.nix
# ==============================================================================
# Provides hardware-specific daemons and utilities for ASUS ROG laptops,
# managing GPU switching (supergfxd) and custom firmware controls (asusd).
# ==============================================================================
{
  flake.nixosModules.asus = {
    config,
    lib,
    pkgs,
    ...
  }: let
    inherit (lib) mkEnableOption mkIf;
    cfg = config.hardware.asus-rog;
  in {
    options.hardware.asus-rog = {
      enable = mkEnableOption "ASUS ROG specific daemons and utilities (supergfxd, asusd)";
    };

    config = mkIf cfg.enable {
      # supergfxd handles graphics switching (hybrid, integrated, compute, vfio)
      services.supergfxd.enable = true;
      systemd.services.supergfxd.path = [pkgs.pciutils];

      # asusd manages fan curves, anime matrix, keyboard LEDs, and battery limits
      services.asusd.enable = true;

      boot = {
        kernelModules = ["asus_wmi"];
      };
    };
  };
}
