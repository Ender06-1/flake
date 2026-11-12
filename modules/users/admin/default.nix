{ den, ... }:

{
  den.aspects.admin = {
    includes = with den.aspects; [
      den.batteries.define-user
      den.batteries.primary-user

      nixvim
    ];

    nixos.users.users.admin.initialPassword = "admin";
  };
}
