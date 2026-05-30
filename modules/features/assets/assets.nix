# assets.nix
{lib, ...}: {
  options.assets = {
    wallpaperDir = lib.mkOption {
      type = lib.types.path;
      default = ./wallpapers;
    };
    avatarPicture = lib.mkOption {
      type = lib.types.path;
      default = ./face.png;
    };
    notifCritical = lib.mkOption {
      type = lib.types.path;
      default = ./sounds/critical.mp3;
    };
    notifNormal = lib.mkOption {
      type = lib.types.path;
      default = ./sounds/normal.mp3;
    };
    notifLow = lib.mkOption {
      type = lib.types.path;
      default = ./sounds/low.mp3;
    };
  };
}
