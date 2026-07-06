# ==============================================================================
# FILE: theme.nix
# ==============================================================================
# Defines the global color palette (Gruvbox-inspired) to be used across the OS.
# Exposes the theme configuration as a flake-level output so any module can
# reference these variables uniformly.
# ==============================================================================
{lib, ...}: let
  # The base16 color palette representing the system-wide theme.
  theme = {
    base00 = "#242424"; # Background
    base01 = "#3c3836"; # Darker background / Status bars
    base02 = "#504945"; # Selection background
    base03 = "#665c54"; # Comments / Invisibles
    base04 = "#bdae93"; # Dark foreground
    base05 = "#d5c4a1"; # Default foreground
    base06 = "#ebdbb2"; # Light foreground
    base07 = "#fbf1c7"; # Lightest foreground
    base08 = "#fb4934"; # Red
    base09 = "#fe8019"; # Orange
    base0A = "#fabd2f"; # Yellow
    base0B = "#b8bb26"; # Green
    base0C = "#8ec07c"; # Cyan
    base0D = "#7daea3"; # Blue
    base0E = "#e089a1"; # Magenta
    base0F = "#f28534"; # Brown / DarkOrange
  };

  # Helper function to remove the '#' prefix from color hex codes,
  # required by certain applications that don't support the hash symbol.
  stripHash = str:
    if lib.hasPrefix "#" str
    then lib.substring 1 (lib.stringLength str - 1) str
    else str;

  themeNoHash = lib.mapAttrs (_: stripHash) theme;
in {
  flake = {
    inherit theme themeNoHash;
  };
}
