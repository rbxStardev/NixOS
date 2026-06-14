{inputs, ...}: {
  perSystem = {
    pkgs,
    system,
    ...
  }: let
    # Apply rust-overlay only on this scope
    pkgsWithRust = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [inputs.rust-overlay.overlays.default];
    };

    rustToolchain = pkgsWithRust.rust-bin.stable.latest.default.override {
      extensions = ["rust-src" "rust-analyzer" "clippy" "rustfmt"];
    };
  in {
    packages.rust-rover = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;

      package = pkgs.jetbrains.rust-rover;

      runtimeInputs = [
        rustToolchain
        pkgs.gcc
        pkgs.gnumake
        pkgs.pkg-config
        pkgs.openssl.dev
      ];

      env = {
        RUST_SRC_PATH = "${rustToolchain}/lib/rustlib/src/rust/library";

        _JAVA_AWT_WM_NONREPARENTING = "1";
      };
    };
  };
}
