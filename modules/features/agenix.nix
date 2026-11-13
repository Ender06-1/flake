{ inputs, ... }:

{
  flake-file.inputs.agenix.url = "github:ryantm/agenix";

  den.aspects.agenix = {
    nixos = {
      imports = [ inputs.agenix.nixosModules.default ];
    };

    homeManager =
      { pkgs, ... }:
      let
        system = pkgs.stdenv.hostPlatform.system;
      in
      {
        imports = [
          inputs.agenix.homeManagerModules.default
        ];

        home.packages = with inputs; [
          agenix.packages.${system}.default
        ];
      };
  };
}
