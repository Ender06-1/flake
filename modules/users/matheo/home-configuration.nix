{ self, inputs, ... }:

{
  flake.homeConfigurations."matheo" = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };

    modules = with self.homeModules; [
      self.homeModules.matheo
      {
        home.username = "matheo";
        home.homeDirectory = "/home/matheo";
      }
    ];
  };

}
