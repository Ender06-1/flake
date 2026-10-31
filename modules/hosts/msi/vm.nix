{ self, ... }:

{
  perSystem = { pkgs, ... }: {
    packages.msi-vm = pkgs.writeShellApplication {
      name = "msi-vm";
      text = ''
        ${self.nixosConfigurations.msi.config.system.build.vm}/bin/run-msi-vm "$@"
      '';
    };
  };
}
