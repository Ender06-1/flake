{
  flake.nixosModules.matheo = {
    services.displayManager.ly = {
      enable = true;
      x11Support = false;
    };

    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };

    services.tailscale.enable = true;
  };

}
