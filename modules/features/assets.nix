{
  flake.nixosModules.assets = {lib, ...}: let
    inherit (lib) mkOption types;
  in {
    options.assets = {
      wallpaperDir = mkOption {
        type = types.str;
        default = "/home/star/Assets/Wallpapers";
        description = "Absolute path to the directory containing background images.";
      };

      avatarPicture = mkOption {
        type = types.str;
        default = "/home/star/Assets/face.png";
        description = "Absolute path to the user's profile picture.";
      };

      notificationSound = mkOption {
        type = types.str;
        default = "/home/star/Assets/Sounds/curse.wav";
        description = "Absolute path to the sound file used for notifications.";
      };
    };
  };
}
