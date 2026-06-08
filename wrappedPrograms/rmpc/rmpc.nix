# ==============================================================================
# FILE: wrappedPrograms/rmpc/rmpc.nix
# ==============================================================================
# Wraps the RMPC (Rusty Music Player Client) executable.
# It creates an isolated configuration directory inside the Nix store using
# `runCommand` and points `XDG_CONFIG_HOME` to it, ensuring that RMPC uses
# the declarative Gruvbox theme without polluting the user's local ~/.config.
# ==============================================================================
{inputs, ...}: {
  perSystem = {pkgs, ...}: let
    # Creates an immutable directory containing the declarative RON configs
    rmpcConfig = pkgs.runCommand "rmpc-config" {} ''
      mkdir -p $out/rmpc/themes
      cp ${./config.ron} $out/rmpc/config.ron
      cp ${./themes/gruvbox.ron} $out/rmpc/themes/gruvbox.ron
    '';
  in {
    packages.rmpc = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.rmpc;

      # Override the config home to read strictly from our derivation
      env = {
        XDG_CONFIG_HOME = "${rmpcConfig}";
      };
    };
  };
}
