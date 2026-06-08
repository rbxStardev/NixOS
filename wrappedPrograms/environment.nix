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
      (inputs.wrappers.wrapperModules.foot.apply {
        inherit pkgs;
        imports = [self.wrappersModules.foot];
        shell = lib.getExe' self'.packages.environment "zsh";
      }).wrapper;

    # Core shell environment packed with developer tools
    packages.environment =
      (inputs.wrappers.lib.wrapPackage {
        inherit pkgs;
        package = self'.packages.zsh;

        # Explicitly list runtime dependencies without using `with pkgs;`
        runtimeInputs = [
          pkgs.tombi
          pkgs.lua-language-server
          pkgs.luau-lsp
          pkgs.stylua
          pkgs.marksman
          pkgs.vscode-json-languageserver
        ];

        env = {
          EDITOR = lib.getExe self'.packages.helix;
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
