{self, ...}: {
  flake.nixosModules.hardware = {
    imports = [
      self.nixosModules.amd
      self.nixosModules.asus
      self.nixosModules.nvidia
    ];
  };
}
