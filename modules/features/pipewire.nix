# ==============================================================================
# FILE: modules/features/pipewire.nix
# ==============================================================================
# Replaces the legacy PulseAudio with PipeWire as the primary audio and video
# routing server. Enables low-latency audio via RTKit and provides full
# backward compatibility with ALSA, PulseAudio, and JACK clients.
# ==============================================================================
{
  flake.nixosModules.pipewire = {
    config,
    lib,
    ...
  }: let
    inherit (lib) mkEnableOption mkIf;
    cfg = config.features.pipewire;
  in {
    options.features.pipewire = {
      enable = mkEnableOption "PipeWire audio/video server and compatibility layers";
    };

    config = mkIf cfg.enable {
      # RealtimeKit is highly recommended for audio workloads to prevent dropouts
      security.rtkit.enable = true;

      # Explicitly disable PulseAudio daemon to prevent conflicts
      services.pulseaudio.enable = false;

      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;

        # WirePlumber is the modern session and policy manager for PipeWire
        wireplumber.enable = true;
      };
    };
  };
}
