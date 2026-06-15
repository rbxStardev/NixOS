# ==============================================================================
# FILE: modules/features/general.nix
# ==============================================================================
# Provides general system utilities, CLI tools, wrapper packages, and the
# default user shell environment.
# ==============================================================================
{self, ...}: {
  flake.nixosModules.general = {
    config,
    pkgs,
    lib,
    ...
  }: let
    inherit (lib) mkEnableOption mkIf;
    cfg = config.features.general;

    # Resolve packages specifically built for the host architecture
    selfpkgs = self.packages."${pkgs.stdenv.hostPlatform.system}";
  in {
    options.features.general = {
      enable = mkEnableOption "General system utilities, wrapper binaries, and base shell";
    };

    # Imports MUST be at the top-level
    # NOTE: Removed self.nixosModules.gtk from here to prevent duplicate
    # module evaluation, as it's already properly imported by desktop.nix
    imports = [
      self.nixosModules.extra_hjem
      self.nixosModules.nix
    ];

    config = mkIf cfg.enable {
      # System-wide packages without using the problematic `with pkgs;` anti-pattern.
      environment.systemPackages = [
        pkgs.nil
        pkgs.nixd
        pkgs.statix
        pkgs.alejandra
        pkgs.manix
        pkgs.nix-inspect

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
        pkgs.fd
        pkgs.ripgrep
        pkgs.tree-sitter
        pkgs.imagemagick
        pkgs.ffmpeg-full
        pkgs.yt-dlp
        pkgs.lazygit

        # Custom wrappers provided by this flake
        selfpkgs.git
        selfpkgs.nix-check-bin
        selfpkgs.helix
        selfpkgs.yazi
        selfpkgs.rmpc
        selfpkgs.starship
        selfpkgs.bat
        selfpkgs.fastfetch
        selfpkgs.tmux
      ];

      # Register the custom wrapper environment as a valid login shell
      environment.shells = [selfpkgs.environment];

      # Dynamic user definition based on the global preferences
      users.users.${config.preferences.user.name} = {
        isNormalUser = true;
        description = "${config.preferences.user.name}'s primary account";
        extraGroups = ["networkmanager" "wheel" "audio" "video"];
        shell = selfpkgs.environment;
        initialPassword = "12345";
      };

      # Ensures ZSH functionality is available system-wide since it's wrapped
      programs.zsh.enable = true;
    };
  };
}
