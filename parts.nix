{inputs, ...}: {
  imports = [
    inputs.wrapper-modules.flakeModules.wrappers
    inputs.flake-parts.flakeModules.modules
  ];

  options = {
    flake = inputs.flake-parts.lib.mkSubmoduleOptions {
      wrappersModules = inputs.nixpkgs.lib.mkOption {
        type = inputs.nixpkgs.lib.types.lazyAttrsOf inputs.nixpkgs.lib.types.deferredModule;
        default = {};
        apply = inputs.nixpkgs.lib.mapAttrs (_: v: {
          imports = [v];
        });
      };
    };
  };

  config = {
    systems = [
      "x86_64-linux"
      "x86_64-darwin"
      "aarch64-linux"
      "aarch64-darwin"
    ];
  };
}
