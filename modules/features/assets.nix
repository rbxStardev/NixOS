# assets.nix
{lib, ...}: {
  options.assets = {
    wallpaperDir = lib.mkOption {
      default = "~/Assets/wallpapers";
    };
    avatarPicture = lib.mkOption {
      default = "~/Assets/face.png";
    };
    notifCritical = lib.mkOption {
      default = "~/Assets/sounds/critical.mp3";
    };
    notifNormal = lib.mkOption {
      default = "~/Assets/sounds/normal.mp3.mp3";
    };
    notifLow = lib.mkOption {
      default = "~/Assets/sounds/low.mp3.mp3";
    };
  };
}
