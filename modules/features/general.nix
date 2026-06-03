{self, ...}: {
  flake.nixosModules.general = {
    config,
    pkgs,
    ...
  }: let
    selfpkgs = self.packages."${pkgs.stdenv.hostPlatform.system}";
  in {
    imports = [
      self.nixosModules.extra_hjem
      self.nixosModules.gtk
      self.nixosModules.nix
    ];

    environment.systemPackages = [
      # nix
      pkgs.nil
      pkgs.nixd
      pkgs.statix
      pkgs.alejandra
      pkgs.manix
      pkgs.nix-inspect

      # other
      pkgs.file
      pkgs.unzip
      pkgs.zip
      pkgs.p7zip
      pkgs.wget
      pkgs.killall
      pkgs.fzf
      pkgs.htop
      pkgs.btop
      pkgs.eza
      pkgs.bat
      pkgs.fd
      pkgs.ripgrep
      pkgs.fastfetch
      pkgs.tree-sitter
      pkgs.imagemagick
      pkgs.ffmpeg-full
      pkgs.yt-dlp
      pkgs.lazygit

      # wrapper
      selfpkgs.git
      selfpkgs.nix-check-bin
      selfpkgs.helix
      selfpkgs.yazi
      selfpkgs.rmpc
      selfpkgs.starship
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
