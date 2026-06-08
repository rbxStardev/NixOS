# ==============================================================================
# FILE: modules/nixpkgs.nix
# ==============================================================================
# Configures the global `pkgs` instance for all flake-parts `perSystem` outputs.
# ==============================================================================
{inputs, ...}: {
  perSystem = {system, ...}: {
    # Injects the customized nixpkgs instance into the module arguments.
    # This allows all other modules to receive `pkgs` with unfree software enabled.
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  };
}
