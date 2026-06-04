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
    packages.terminal =
      (inputs.wrappers.wrapperModules.foot.apply {
        inherit pkgs;
        imports = [self.wrappersModules.foot];
        shell = lib.getExe' self'.packages.environment "zsh";
      }).wrapper;

    packages.environment =
      (inputs.wrappers.lib.wrapPackage {
        inherit pkgs;
        package = self'.packages.zsh;
        runtimeInputs = with pkgs; [
          tombi

          lua-language-server
          luau-lsp
          stylua

          marksman

          vscode-json-languageserver
        ];
        env = {
          EDITOR = lib.getExe self'.packages.helix;
        };
      }).overrideAttrs (old: {
        meta = (old.meta or {}) // {mainProgram = "zsh";};
        passthru = (old.passthru or {}) // {shellPath = "/bin/zsh";};
      });

    packages.nix-check-bin = pkgs.writeShellApplication {
      name = "nix-check-bin";
      text = ''
        $EDITOR "$(nix build "$1" --no-link --print-out-paths)/bin"
      '';
    };
  };
}
