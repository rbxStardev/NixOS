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
      (inputs.wrappers.wrapperModules.alacritty.apply {
        inherit pkgs;
        imports = [self.wrappersModules.alacritty];
        shell = lib.getExe' self'.packages.environment "zsh";
      }).wrapper;

    packages.environment =
      (inputs.wrappers.lib.wrapPackage {
        inherit pkgs;
        package = self'.packages.zsh;
        runtimeInputs = [
          # nix
          pkgs.nil
          pkgs.nixd
          pkgs.statix
          pkgs.alejandra
          pkgs.manix
          pkgs.nix-inspect
          self'.packages.nh

          # other
          pkgs.file
          pkgs.unzip
          pkgs.zip
          pkgs.p7zip
          pkgs.wget
          pkgs.killall
          pkgs.fzf
          pkgs.htop
          pkgs.btop
          pkgs.eza
          pkgs.fd
          pkgs.ripgrep
          pkgs.fastfetch
          pkgs.tree-sitter
          pkgs.imagemagick
          pkgs.ffmpeg-full
          pkgs.yt-dlp
          pkgs.lazygit
          pkgs.yazi

          # wrapper
          self'.packages.git
          self'.packages.nix-check-bin
          self'.packages.helix
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
