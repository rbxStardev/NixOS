# ==============================================================================
# FILE: modules/features/assets.nix
# ==============================================================================
# Defines paths to critical system assets (wallpapers, sounds, avatars).
# Refactored to dynamically resolve the user's home directory based on the
# system preferences rather than hardcoding "/home/star/".
# ==============================================================================
{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption types;
  # Dynamically calculate the home directory for asset resolution
  # homeDir = "/home/${config.preferences.user.name}";
in {
  options.assets = {
    wallpaperDir = mkOption {
      type = types.str;
      # default = "${homeDir}/Assets/Wallpapers";
      default = "/home/star/Assets/Wallpapers";
      description = "Absolute path to the directory containing background images.";
    };

    avatarPicture = mkOption {
      type = types.str;
      # default = "${homeDir}/Assets/face.png";
      default = "/home/star/Assets/face.png";
      description = "Absolute path to the user's profile picture.";
    };

    notificationSound = mkOption {
      type = types.str;
      default = "/home/star/Assets/Sounds/curse.wav";
      description = "Absolute path to the sound file used for notifications.";
    };

    notifCritical = mkOption {
      type = types.str;
      # default = "${homeDir}/Assets/Sounds/critical.mp3";
      default = "/home/star/Assets/Sounds/critical.mp3";
      description = "Absolute path to the sound file used for critical notifications.";
    };

    notifNormal = mkOption {
      type = types.str;
      # default = "${homeDir}/Assets/Sounds/normal.mp3";
      default = "/home/star/Assets/Sounds/normal.mp3";
      description = "Absolute path to the sound file used for normal notifications.";
    };

    notifLow = mkOption {
      type = types.str;
      # default = "${homeDir}/Assets/Sounds/low.mp3";
      default = "/home/star/Assets/Sounds/low.mp3";
      description = "Absolute path to the sound file used for low priority notifications.";
    };
  };
}
