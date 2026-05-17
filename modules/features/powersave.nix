{
  flake.nixosModules.powersave = {
    pkgs,
    lib,
    ...
  }: {
    services.power-profiles-daemon.enable = true;
    services.thermald.enable = true;
  };
}
