{self, ...}: {
  flake.nixosModules.general = {config, ...}: {
    imports = [
      self.nixosModules.extra_hjem
      self.nixosModules.gtk
      self.nixosModules.nix
    ];

    users.users.${config.preferences.user.name} = {
      isNormalUser = true;
      description = "${config.preferences.user.name}'s account";
      extraGroups = ["networkmanager" "wheel" "audio" "video"];

      initialPassword = "12345";
    };

    programs.zsh.enable = true;
  };
}
