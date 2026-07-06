# ==============================================================================
# FILE: wrappedPrograms/environment.nix
# ==============================================================================
# Defines the core interactive environment packages. It bundles `zsh` with
# necessary LSP servers and developer tools, effectively creating an
# isolated and fully-featured default shell experience.
# ==============================================================================
{
  lib,
  inputs,
  self,
  ...
}: {
  perSystem = {
    pkgs,
    self',
    ...
  }: {
    # Wrapped terminal emulator explicitly bound to my wrapped shell
    packages.terminal =
      (inputs.wrappers.wrapperModules.kitty.apply {
        inherit pkgs;
        imports = [self.wrappersModules.kitty];
      }).wrapper;

    # Core shell environment packed with developer tools
    packages.environment =
      (inputs.wrappers.lib.wrapPackage {
        inherit pkgs;
        package = self'.packages.zsh;

        env = {
          EDITOR = "nvim";
        };
      }).overrideAttrs (old: {
        meta = (old.meta or {}) // {mainProgram = "zsh";};
        passthru = (old.passthru or {}) // {shellPath = "/bin/zsh";};
      });

    # Simple helper script to inspect binary outputs from derivations
    packages.nix-check-bin = pkgs.writeShellApplication {
      name = "nix-check-bin";
      text = ''
        $EDITOR "$(nix build "$1" --no-link --print-out-paths)/bin"
      '';
    };
  };
}
