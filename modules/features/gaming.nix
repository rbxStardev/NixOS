{
  flake.nixosModules.gaming = {pkgs, ...}: {
    hardware.graphics.enable = true;

    environment.systemPackages = with pkgs; [
      hydralauncher
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
