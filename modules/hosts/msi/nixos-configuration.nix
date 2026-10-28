{ self, inputs, ... }:

{
  flake.nixosConfigurations."msi" = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.msi
      self.nixosModules.matheo

      {
        imports = [
          inputs.home-manager.nixosModules.home-manager
        ];

        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "bak";
        };
      }
    ];
  };
}
