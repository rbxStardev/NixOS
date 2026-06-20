# ==============================================================================
# FILE: modules/hardware/nvidia.nix
# ==============================================================================
# Configures microcode updates, kernel parameters and modules for AMD CPUs
# ==============================================================================
{
  flake.nixosModules.amd = {
    config,
    lib,
    ...
  }: let
    inherit (lib) mkEnableOption mkIf;
    cfg = config.hardware.amd-cpu;
  in {
    options.hardware.amd-cpu = {
      enable = mkEnableOption "AMD cpu optimizations";
    };

    config = mkIf cfg.enable {
      hardware.cpu.amd.updateMicrocode = true;

      boot = {
        kernelParams = [
          "amd_pstate=active"
        ];

        kernelModules = ["k10temp"];
      };
    };
  };
}
