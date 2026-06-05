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
