# ==============================================================================
# FILE: flake.nix
# ==============================================================================
# This is the main entry point of the NixOS configuration.
# It uses `flake-parts` to structure the flake outputs cleanly and dynamically
# imports all Nix modules within the repository using a custom fileset logic.
# ==============================================================================
{
  description = "Advanced NixOS Configuration utilizing flake-parts and wrappers";

  inputs = {
    # Core system inputs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    # External tooling and databases
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Wrapper modules for isolated package configuration
    wrappers = {
      url = "github:Lassulus/wrappers";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wrapper-modules = {
      url = "github:BirdeeHub/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home directory manager (lightweight alternative to home-manager)
    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Noctalia Shell and its plugins
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia-plugins = {
      url = "github:noctalia-dev/legacy-v4-plugins";
      flake = false;
    };

    # External themes
    alacritty-theme.url = "github:alexghr/alacritty-theme.nix";
  };

  outputs = inputs: let
    inherit (inputs.nixpkgs) lib;
    inherit (lib.fileset) toList fileFilter;

    # Determines if a file is a valid Nix module to be auto-imported.
    # Excludes the main flake.nix and any file prefixed with an underscore (_).
    isNixModule = file:
      file.hasExt "nix"
      && file.name != "flake.nix"
      && !lib.hasPrefix "_" file.name;

    # Recursively finds and lists all valid Nix modules in a given path.
    importTree = path: toList (fileFilter isNixModule path);

    # Initialize flake-parts
    mkFlake = inputs.flake-parts.lib.mkFlake {inherit inputs;};
  in
    mkFlake {
      # Automatically import every `.nix` file in the repository into the flake-parts module system.
      imports = importTree ./.;
      debug = true;
    };
}
