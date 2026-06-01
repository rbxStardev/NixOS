{inputs, ...}: {
  perSystem = {pkgs, ...}: let
    # Baixa o tema direto do GitHub
    yazi-gruvbox = pkgs.fetchFromGitHub {
      owner = "bennyyip";
      repo = "gruvbox-dark.yazi";
      rev = "91fdfa70f6d593934e62aba1e449f4ec3d3ccc90";
      hash = "sha256-RWqyAdETD/EkDVGcnBPiMcw1mSd78Aayky9yoxSsry4=";
    };

    yaziConfig = pkgs.runCommand "yazi-config" {} ''
      mkdir -p $out/flavors/gruvbox-dark.yazi
      cp -r ${yazi-gruvbox}/* $out/flavors/gruvbox-dark.yazi/

      cat > $out/theme.toml <<EOF
      [flavor]
      use = "gruvbox-dark"
      EOF
    '';
  in {
    packages.yazi = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.yazi;
      env = {
        YAZI_CONFIG_HOME = "${yaziConfig}";
      };
    };
  };
}
