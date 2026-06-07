# assets.nix
{lib, ...}: {
  options.assets = {
    wallpaperDir = lib.mkOption {
      default = "/home/star/Assets/Wallpapers";
    };
    avatarPicture = lib.mkOption {
      default = "/home/star/Assets/face.png";
    };
    notifCritical = lib.mkOption {
      default = "/home/star/Assets/Sounds/critical.mp3";
    };
    notifNormal = lib.mkOption {
      default = "/home/star/Assets/Sounds/normal.mp3.mp3";
    };
    notifLow = lib.mkOption {
      default = "/home/star/Assets/Sounds/low.mp3.mp3";
    };
  };
}
