{
  flake.nixosModules.gaming = {pkgs, ...}: let
    jsab = pkgs.makeDesktopItem {
      name = "just-shapes-and-beats";
      desktopName = "Just Shapes and Beats";
      comment = "Play this game on Steam";
      exec = "steam steam://rungameid/10725085396061913088";
      icon = "/home/star/Games/Just Shapes and Beats v1.6.50/icon.png";
      categories = ["Game"];
      terminal = false;
    };

    legoBatmanLotDK = pkgs.makeDesktopItem {
      name = "lego-batman";
      desktopName = "LEGO Batman: Legacy of the Dark Knight";
      comment = "Play this game on Steam";
      exec = "steam steam://rungameid/9700019291125972992";
      icon = "/home/star/Games/LEGO Batman - Legacy of the Dark Knight/icon.png";
      categories = ["Game"];
      terminal = false;
    };
  in {
    hardware.graphics.enable = true;

    environment.systemPackages = [
      pkgs.hydralauncher

      jsab
      legoBatmanLotDK
    ];

    programs = {
      gamemode.enable = true;
      gamescope.enable = true;
      steam = {
        enable = true;
        protontricks.enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
      };
    };
  };
}
