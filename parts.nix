# ==============================================================================
# FILE: parts.nix
# ==============================================================================
# This file configures the flake-parts ecosystem. It defines the supported
# systems and introduces custom flake outputs, such as `wrappersModules`,
# to expose modular configurations for wrapped programs.
# ==============================================================================
{
  inputs,
  lib,
  ...
}: let
  inherit (lib) mkOption types mapAttrs;
in {
  imports = [
    inputs.wrapper-modules.flakeModules.wrappers
    inputs.flake-parts.flakeModules.modules
  ];

  options = {
    # Extend the flake-parts options to inject a custom top-level output.
    flake = inputs.flake-parts.lib.mkSubmoduleOptions {
      wrappersModules = mkOption {
        type = types.lazyAttrsOf types.deferredModule;
        default = {};
        description = "Exported wrapper modules to be consumed by the system configuration.";
        # Automatically wrap each exposed module inside an `imports` list
        # so they can be natively evaluated by the wrapper engine.
        apply = mapAttrs (_: v: {
          imports = [v];
        });
      };
    };
  };

  config = {
    # Define which systems this flake explicitly supports.
    systems = [
      "x86_64-linux"
      "x86_64-darwin"
      "aarch64-linux"
      "aarch64-darwin"
    ];
  };
}
