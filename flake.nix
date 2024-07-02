{
  description = "Quickemu flake";
  inputs = {
    flake-schemas.url = "https://flakehub.com/f/DeterminateSystems/flake-schemas/*.tar.gz";
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/*.tar.gz";
  };

  outputs = {
    self,
    flake-schemas,
    nixpkgs,
  }: let
      # Define supported systems and a helper function for generating system-specific outputs
      supportedSystems = [ "x86_64-linux" "x86_64-darwin" "aarch64-darwin" "aarch64-linux" ];

      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        system = system;
        pkgs = import nixpkgs { inherit system; };
      });
  in {
    # Define schemas for the flake's outputs
    schemas = flake-schemas.schemas;

    # Define overlays for each supported system
    overlays = forEachSupportedSystem ({pkgs, system, ...}: {
      default = final: prev: {
        quickemu = final.callPackage ./package.nix { };
      };
    });

    # Define packages for each supported system
    packages = forEachSupportedSystem ({pkgs, system, ...}: rec {
      quickemu = pkgs.callPackage ./package.nix { };
      default = quickemu;
    });

    # Define devShells for each supported system
    devShells = forEachSupportedSystem ({pkgs, system, ...}: {
      default = pkgs.callPackage ./devshell.nix { };
    });
  };
}
