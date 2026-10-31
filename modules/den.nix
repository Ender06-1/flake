{ lib, ... }:

{
  den.default.nixos = {
    system.stateVersion = "26.05";

    home-manager = {
      backupFileExtension = "bak";

      useGlobalPkgs = true;
      useUserPackages = true;
    };
  };

  den.default.homeManager.home.stateVersion = "26.05";

  den.schema.user.classes = lib.mkDefault [ "homeManager" ];
}
