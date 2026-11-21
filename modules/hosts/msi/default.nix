{ den, ... }:

{
  den.hosts.x86_64-linux.msi.users.matheo = { };

  den.aspects.msi = {
    includes = with den.aspects; [
      matheo.hyprland
      matheo.games
    ];

    nixos =
      { pkgs, ... }:
      {
        imports = [
          ./_hardware-configuration.nix
        ];

        nixpkgs.config.allowUnfree = true;

        nix.settings.experimental-features = [
          "nix-command"
          "flakes"
        ];

        boot.loader.limine = {
          enable = true;
          secureBoot.enable = true;
        };

        boot.loader.efi.canTouchEfiVariables = true;
        boot.initrd.luks.devices.cryptroot.device =
          "/dev/disk/by-uuid/77a5e5f4-0dbb-4c42-bd06-6d70eda481c4";

        boot.kernelPackages = pkgs.linuxPackages_zen;

        networking.hostName = "msi";

        networking.networkmanager.enable = true;

        time.timeZone = "Europe/Paris";

        i18n.defaultLocale = "en_US.UTF-8";
        console.keyMap = "us";

        environment.systemPackages = with pkgs; [
          sbctl
        ];

        hardware.bluetooth = {
          enable = true;
          settings = {
            General = {
              Enable = "Source,Sink,Media,Socket";
              Experimental = true;
            };
          };
        };

        services.displayManager.ly = {
          enable = true;
          x11Support = false;
        };

        services.tailscale.enable = true;
      };
  };
}
