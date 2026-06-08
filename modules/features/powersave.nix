# ==============================================================================
# FILE: modules/features/powersave.nix
# ==============================================================================
# Enables background daemons to manage battery life and thermal throttling
# effectively on mobile devices and laptops.
# ==============================================================================
{
  flake.nixosModules.powersave = {
    config,
    lib,
    ...
  }: let
    inherit (lib) mkEnableOption mkIf;
    cfg = config.features.powersave;
  in {
    options.features.powersave = {
      enable = mkEnableOption "Power management and thermal throttling daemons";
    };

    config = mkIf cfg.enable {
      # Handles user-space power profile switching (Performance/Balanced/Power-saver)
      services.power-profiles-daemon.enable = true;

      # Prevents modern Intel/AMD CPUs from overheating by adjusting p-states
      services.thermald.enable = true;
    };
  };
}
