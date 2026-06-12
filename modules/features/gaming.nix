# ==============================================================================
# FILE: modules/features/gaming.nix
# ==============================================================================
# Aggregates gaming dependencies, including Steam, GameMode, and Gamescope
# for micro-compositing and performance enhancements.
# ==============================================================================
{
  flake.nixosModules.gaming = {
    pkgs,
    config,
    lib,
    ...
  }: let
    inherit (lib) mkEnableOption mkIf;
    cfg = config.features.gaming;
  in {
    options.features.gaming = {
      enable = mkEnableOption "Gaming utilities, Steam, and performance tools";
    };

    config = mkIf cfg.enable {
      # Ensure 3D acceleration and graphics APIs (Vulkan/OpenGL) are enabled
      hardware.graphics.enable = true;

      environment.systemPackages = [
        pkgs.hydralauncher

        (pkgs.prismlauncher.override {
          jdks = [pkgs.graalvmPackages.graalvm-ce pkgs.zulu8 pkgs.zulu17 pkgs.zulu21 pkgs.zulu];
        })
      ];

      programs = {
        # Feral Interactive's GameMode daemon for CPU/GPU optimizations
        gamemode.enable = true;

        # Valve's micro-compositor for resolution scaling and frame pacing
        gamescope.enable = true;

        steam = {
          enable = true;
          protontricks.enable = true;
          # Automatically open firewall ports for local network streaming
          remotePlay.openFirewall = true;
          # Automatically open firewall ports for Source engine dedicated servers
          dedicatedServer.openFirewall = true;
        };
      };
    };
  };
}
