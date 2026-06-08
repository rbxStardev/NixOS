# ==============================================================================
# FILE: wrappedPrograms/noctalia/noctalia.nix
# ==============================================================================
# Base wrapper for Noctalia-shell (a Quickshell-based DE component).
# Defines core application properties, cache directories, and the foundational
# color palette (Material You / Gruvbox inspired) used across all widgets.
# ==============================================================================
{
  self,
  inputs,
  ...
}: {
  flake.wrappersModules.noctalia-shell = {pkgs, ...}: {
    # Override the base package name
    package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs {
      name = "starnoctalia";
    };

    # Force a specific cache directory to prevent state corruption
    env = {
      NOCTALIA_CACHE_DIR = "/tmp/star-noctalia-cache";
    };

    # Global Material Design color mapping
    colors = {
      mError = "#fb4934";
      mHover = "#83a598";
      mOnError = "#282828";
      mOnHover = "#282828";
      mOnPrimary = "#282828";
      mOnSecondary = "#282828";
      mOnSurface = "#fbf1c7";
      mOnSurfaceVariant = "#ebdbb2";
      mOnTertiary = "#282828";
      mOutline = "#57514e";
      mPrimary = "#b8bb26";
      mSecondary = "#fabd2f";
      mShadow = "#282828";
      mSurface = "#282828";
      mSurfaceVariant = "#3c3836";
      mTertiary = "#83a598";
    };
  };

  perSystem = {pkgs, ...}: {
    packages.noctalia-shell = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
      inherit pkgs;
      imports = [self.wrappersModules.noctalia-shell];
    };
  };
}
