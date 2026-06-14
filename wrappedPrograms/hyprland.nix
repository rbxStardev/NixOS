# ==============================================================================
# FILE: wrappedPrograms/hyprland.nix
# ==============================================================================
# Wraps the Hyprland compositor binary. This ensures that essential runtime
# dependencies (like clipboard managers and brightness control) are always
# available within Hyprland's context without polluting the global environment.
# ==============================================================================
{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.hyprland = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

      runtimeInputs = [
        pkgs.hypridle
        pkgs.wl-clipboard
        pkgs.cliphist
        pkgs.brightnessctl
        pkgs.thunar
        pkgs.thunar-archive-plugin
        pkgs.xarchiver
      ];

      # Force Wayland mode for Electron/Chromium apps globally within the session
      env = {
        NIXOS_OZONE_WL = "1";
      };
    };
  };
}
