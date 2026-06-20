{
  flake.nixosModules.zerotierone = {
    config,
    lib,
    ...
  }: let
    inherit (lib) mkEnableOption mkIf;
    cfg = config.features.zerotierone;
  in {
    options.features.zerotierone = {
      enable = mkEnableOption "Networking software";
    };

    config = mkIf cfg.enable {
      services.zerotierone = {
        enable = true;
        joinNetworks = ["2873fd00f2015084"];
      };
    };
  };
}
