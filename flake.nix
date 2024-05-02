{
  description = "Quickemu flake";
  inputs = {
    flake-schemas.url = "https://flakehub.com/f/DeterminateSystems/flake-schemas/*.tar.gz";
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.*.tar.gz";
  };

  outputs = {
    self,
    flake-schemas,
    nixpkgs,
  }: let
    forAllSystems = function:
      nixpkgs.lib.genAttrs [
        "x86_64-linux"
        # TODO: Add support for these platforms in quickemu and quickget
        # "aarch64-linux"
        # "x86_64-darwin"
        # "aarch64-darwin"
      ] (system: function nixpkgs.legacyPackages.${system});
  in {
    # Schemas tell Nix about the structure of your flake's outputs
    schemas = flake-schemas.schemas;

    overlays.default = final: prev: {
      quickemu = final.callPackage ./package.nix {};
    };

    packages = forAllSystems (pkgs: rec {
      quickemu = pkgs.callPackage ./package.nix {};
      default = quickemu;
    });

    devShells = forAllSystems (pkgs: {
      default = pkgs.callPackage ./devshell.nix {};
    });
  };
}
