{ inputs, ... }:

{
  flake-file.inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";

    import-tree.url = "github:vic/import-tree";

    caelestia-shell = {
      url = "github:caelestia-dots/shell?ref=v2.5.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-file.url = "github:denful/flake-file";
  };

  imports = [
    inputs.flake-file.flakeModules.dendritic

    inputs.home-manager.flakeModules.home-manager
  ];

  systems = [
    "x86_64-linux"
  ];
}
