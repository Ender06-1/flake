{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
  };

  outputs = { nixpkgs, home-manager, ... }: {
    nixosConfigurations."msi" = nixpkgs.lib.nixosSystem {
      modules = [
        ./modules/hosts/msi/configuration.nix

	home-manager.nixosModules.home-manager
	{
	  home-manager = {
	    useGlobalPkgs = true;
	    useUserPackages = true;
	    users.matheo = ./modules/users/matheo/home.nix;
	  };
	}
      ];
    };
  };
}
