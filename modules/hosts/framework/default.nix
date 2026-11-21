{ den, ... }:
{
  den.hosts.x86_64-linux.framework.users.matheo = { };

  den.aspects.framework = {
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
          "/dev/disk/by-uuid/815617d8-950b-4eab-8bf5-dd588ff0808b";

        boot.kernelPackages = pkgs.linuxPackages_zen;

        networking.hostName = "framework";

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
