{self, ...}: {
  flake.nixosModules.features = {
    imports = [
      self.nixosModules.appimage
      self.nixosModules.assets
      self.nixosModules.bootloader
      self.nixosModules.chromium
      self.nixosModules.desktop
      self.nixosModules.discord
      self.nixosModules.extra_hjem
      self.nixosModules.firefox
      self.nixosModules.fonts
      self.nixosModules.gaming
      self.nixosModules.general
      self.nixosModules.hyprland
      self.nixosModules.locale
      self.nixosModules.nix
      self.nixosModules.noctalia
      self.nixosModules.pipewire
      self.nixosModules.powersave
      self.nixosModules.sddm-astronaut
      self.nixosModules.sddm
      self.nixosModules.virtualization
      self.nixosModules.zerotierone
      self.nixosModules.zeditor
    ];
  };
}
