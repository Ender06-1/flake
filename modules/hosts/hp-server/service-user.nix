{ den, ... }:

{
  den.aspects.hp-server.service-user = { user, ... }: {
    includes = with den.aspects; [
      nixvim
      fish
      starship
      eza
      bat
    ];

  };
}
