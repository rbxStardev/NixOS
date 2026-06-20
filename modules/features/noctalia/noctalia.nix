# ==============================================================================
# FILE: modules/features/noctalia/noctalia.nix
# ==============================================================================
# Core configuration for the Noctalia v5 Wayland shell.
# Integrates the native C++ shell into the system via Hjem.
# ==============================================================================
{
  inputs,
  self,
  ...
}: {
  flake.nixosModules.noctalia = {
    config,
    pkgs,
    ...
  }: {
    hjem = {
      extraModules = [
        inputs.noctalia.hjemModules.default
      ];

      users.${config.preferences.user.name} = {
        imports = [
          (args: import ./_settings.nix (args // {osConfig = config;}))
        ];

        programs.noctalia = {
          enable = true;
          systemd.enable = true;

          package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs {
            name = "starnoctalia";
          };

          # Define the Gruvbox custom palette mapping.
          # Noctalia v5 will load this as a custom palette dynamically.
          customPalettes = {
            gruvbox = {
              dark = {
                mPrimary = "#b8bb26";
                mOnPrimary = "#282828";
                mSecondary = "#fabd2f";
                mOnSecondary = "#282828";
                mTertiary = "#83a598";
                mOnTertiary = "#282828";
                mError = "#fb4934";
                mOnError = "#282828";
                mSurface = "#282828";
                mOnSurface = "#fbf1c7";
                mSurfaceVariant = "#3c3836";
                mOnSurfaceVariant = "#ebdbb2";
                mOutline = "#57514e";
                mShadow = "#282828";
                mHover = "#83a598";
                mOnHover = "#282828";
              };
            };
          };
        };
      };
    };
  };
}
