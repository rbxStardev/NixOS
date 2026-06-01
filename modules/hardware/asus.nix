{
  flake.nixosModules.asus = {pkgs, ...}: {
    services.supergfxd.enable = true;
    systemd.services.supergfxd.path = [pkgs.pciutils];
    services.asusd.enable = true;
  };
}
