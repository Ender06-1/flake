{ inputs, ... }:

{
  imports = [
    inputs.den.flakeModules.dendritic
    inputs.flake-file.flakeModules.dendritic

    inputs.home-manager.flakeModules.home-manager
  ];

  flake-file.inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";

    import-tree.url = "github:vic/import-tree";

    flake-file.url = "github:denful/flake-file";

    den.url = "github:denful/den";
  };
}
