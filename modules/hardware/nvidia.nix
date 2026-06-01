{
  flake.nixosModules.nvidia = {config, ...}: {
    hardware.nvidia = {
      powerManagement.enable = true;

      open = false;

      nvidiaSettings = true;

      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
