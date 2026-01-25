{
  description = "Quickemu flake";
  inputs = {
    flake-schemas.url = "https://flakehub.com/f/DeterminateSystems/flake-schemas/*.tar.gz";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    {
      self,
      flake-schemas,
      nixpkgs,
    }:
    let
      # Define supported systems and a helper function for generating system-specific outputs
      supportedSystems = [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
        "aarch64-linux"
      ];

      forEachSupportedSystem =
        f:
        nixpkgs.lib.genAttrs supportedSystems (
          system:
          f {
            system = system;
            pkgs = import nixpkgs { inherit system; };
          }
        );
    in
    {
      # Define schemas for the flake's outputs
      schemas = flake-schemas.schemas;

      # Define overlays for each supported system
      overlays = {
        default =
          final: prev:
          let
            # OVMF is only available/needed on Linux
            ovmfArgs =
              if final.stdenv.hostPlatform.isLinux then
                { }
              else
                {
                  OVMF = null;
                  OVMFFull = null;
                };
          in
          {
            quickemu = final.callPackage ./package.nix ovmfArgs;
          };
      };

      # Define packages for each supported system
      packages = forEachSupportedSystem (
        { pkgs, system, ... }:
        let
          # OVMF is only available/needed on Linux
          ovmfArgs =
            if pkgs.stdenv.hostPlatform.isLinux then
              { }
            else
              {
                OVMF = null;
                OVMFFull = null;
              };
        in
        rec {
          quickemu = pkgs.callPackage ./package.nix ovmfArgs;
          default = quickemu;
        }
      );

      # Define devShells for each supported system
      devShells = forEachSupportedSystem (
        { pkgs, system, ... }:
        let
          # OVMF is only available/needed on Linux
          ovmfArgs =
            if pkgs.stdenv.hostPlatform.isLinux then
              { }
            else
              {
                OVMF = null;
                OVMFFull = null;
              };
        in
        {
          default = pkgs.callPackage ./devshell.nix ovmfArgs;
        }
      );
    };
}
