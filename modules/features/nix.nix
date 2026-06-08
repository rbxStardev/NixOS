# ==============================================================================
# FILE: modules/features/nix.nix
# ==============================================================================
# Configures the Nix package manager itself, enabling flakes, automatic
# optimization, the comma tool (nix-index), and direnv for local environments.
# ==============================================================================
{inputs, ...}: {
  flake.nixosModules.nix = {
    pkgs,
    config,
    lib,
    ...
  }: let
    inherit (lib) mkEnableOption mkIf;
    cfg = config.features.nix;
    user = config.preferences.user.name;
  in {
    options.features.nix = {
      enable = mkEnableOption "Advanced Nix package manager settings and helpers";
    };

    # Imports MUST be at the top-level
    imports = [
      inputs.nix-index-database.nixosModules.nix-index
    ];

    config = mkIf cfg.enable {
      # Allows running uninstalled commands seamlessly (e.g., `, cowsay`)
      programs.nix-index-database.comma.enable = true;

      programs.direnv = {
        enable = true;
        silent = true;
        loadInNixShell = true;
        direnvrcExtra = "";
        nix-direnv.enable = true;
      };

      # 'nh' is a modern wrapper around nixos-rebuild and nix build
      programs.nh = {
        enable = true;
        flake = "/home/${user}/NixOS";
        clean = {
          enable = true;
          extraArgs = "--keep-since 7d --keep 3";
        };
      };

      # Core Nix daemon configuration
      nix.settings = {
        experimental-features = ["nix-command" "flakes"];
        auto-optimise-store = true;
      };

      # Run unpatched dynamic binaries on NixOS
      programs.nix-ld.enable = true;
      nixpkgs.config.allowUnfree = true;

      environment.systemPackages = [
        pkgs.nil
        pkgs.nixd
        pkgs.statix
        pkgs.alejandra
        pkgs.manix
        pkgs.nix-inspect
      ];
    };
  };
}
