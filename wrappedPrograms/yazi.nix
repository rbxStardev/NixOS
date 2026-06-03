{inputs, ...}: {
  perSystem = {pkgs, ...}: let
    yazi-gruvbox = pkgs.fetchFromGitHub {
      owner = "bennyyip";
      repo = "gruvbox-dark.yazi";
      rev = "619fdc5844db0c04f6115a62cf218e707de2821e";
      hash = "sha256-RWqyAdETD/EkDVGcnBPiMcw1mSd78Aayky9yoxSsry4=";
    };

    yaziConfig = pkgs.symlinkJoin {
      name = "yazi-config";
      paths = [
        (pkgs.writeTextDir "theme.toml" ''
          [flavor]
          dark = "gruvbox-dark"
          light = "gruvbox-dark"
        '')
        (pkgs.runCommand "yazi-flavors" {} ''
          mkdir -p $out/flavors
          ln -s ${yazi-gruvbox} $out/flavors/gruvbox-dark.yazi
        '')
      ];
    };
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
