{inputs, ...}: {
  perSystem = {pkgs, ...}: let
    rmpcConfig = pkgs.runCommand "rmpc-config" {} ''
      mkdir -p $out/rmpc/themes
      cp ${./config.ron} $out/rmpc/config.ron
      cp ${./themes/gruvbox.ron} $out/rmpc/themes/gruvbox.ron
    '';
  in {
    packages.rmpc = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.rmpc;
      env = {
        XDG_CONFIG_HOME = "${rmpcConfig}";
      };
    };
  };
}
