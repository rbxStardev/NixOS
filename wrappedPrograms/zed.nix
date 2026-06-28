# ==============================================================================
# FILE: wrappedPrograms/zed.nix
# ==============================================================================
{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.zed = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.zed-editor;

      runtimeInputs = [
        pkgs.nixd
        pkgs.nil
        pkgs.alejandra
        pkgs.tombi
        pkgs.lua-language-server
        pkgs.luau-lsp
        pkgs.stylua
        pkgs.marksman
        pkgs.vscode-json-languageserver
      ];
    };
  };
}
