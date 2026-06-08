# ==============================================================================
# FILE: wrappedPrograms/bat.nix
# ==============================================================================
# Wraps the `bat` utility (a cat clone with syntax highlighting) to inject
# a predefined theme (gruvbox-dark) consistently.
# ==============================================================================
{
  self,
  inputs,
  ...
}: {
  flake.wrappersModules.bat = {
    "bat-config".content = ''
      --theme="gruvbox-dark"
    '';
  };

  perSystem = {pkgs, ...}: {
    packages.bat =
      (inputs.wrappers.wrapperModules.bat.apply {
        inherit pkgs;
        imports = [self.wrappersModules.bat];
      }).wrapper;
  };
}
