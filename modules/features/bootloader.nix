{
  flake.nixosModules.bootloader = {
    pkgs,
    config,
    lib,
    ...
  }: let
    inherit (lib) mkEnableOption mkIf;
    cfg = config.features.bootloader;
  in {
    options.features.bootloader = {
      enable = mkEnableOption "Enabled preferred bootloader alongside with necessary kernel modules and parameters";
    };

    config = mkIf cfg.enable {
      boot = {
        kernelPackages = pkgs.linuxPackages_latest;

        # Limine Bootloader configuration
        loader.limine.enable = true;
        loader.limine.efiSupport = true;
        loader.efi.canTouchEfiVariables = true;
        loader.timeout = 0;

        supportedFilesystems.ntfs = true;
        consoleLogLevel = 0;

        kernelParams = [
          "quiet"
          "splash"
          "rd.systemd.show_status=false"
          "rd.udev.log_level=3"
          "udev.log_priority=3"
          "vt.global_cursor_default=0"
        ];

        kernelModules = ["rtw89_8852be" "cpuid" "v4l2loopback" "tcp_bbr"];
        binfmt.emulatedSystems = ["aarch64-linux"];

        plymouth.enable = true;
        initrd.systemd.enable = true;

        # Network throughput optimizations
        kernel.sysctl = {
          "net.ipv4.tcp_congestion_control" = "bbr";
          "net.core.default_qdisc" = "fq";
        };
      };
    };
  };
}
