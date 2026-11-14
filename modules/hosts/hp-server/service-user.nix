{ den, ... }:

{
  den.aspects.service-user = {
    includes = with den.aspects; [
      nixvim
      fish
      starship
      eza
      bat
    ];

    user.extraGroups = [ "systemd-journal" ];
  };
}
