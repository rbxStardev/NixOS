# ==============================================================================
# FILE: modules/extra/hjem.nix
# ==============================================================================
# Integrates `hjem`, a lightweight alternative to home-manager, managing
# dotfiles and user-specific configurations declaratively.
# ==============================================================================
{inputs, ...}: {
  flake.nixosModules.extra_hjem = {config, ...}: let
    # Inherit the dynamically configured username
    user = config.preferences.user.name;
  in {
    imports = [
      inputs.hjem.nixosModules.default
    ];

    config = {
      hjem = {
        users."${user}" = {
          enable = true;
          directory = "/home/${user}";
          user = "${user}";
        };
      };
    };
  };
}
