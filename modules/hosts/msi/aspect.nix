{
  den.aspects.msi = {
    nixos =
      {
        config,
        lib,
        pkgs,
        modulesPath,
        ...
      }:
      {
        imports = [
          (modulesPath + "/installer/scan/not-detected.nix")
        ];

        boot.initrd.availableKernelModules = [
          "nvme"
          "xhci_pci"
          "ahci"
          "usb_storage"
          "usbhid"
          "sd_mod"
        ];
        boot.initrd.kernelModules = [ "dm-snapshot" ];
        boot.kernelModules = [ "kvm-amd" ];
        boot.extraModulePackages = [ ];

        fileSystems."/" = {
          device = "/dev/mapper/vgroot-root";
          fsType = "ext4";
        };

        fileSystems."/boot" = {
          device = "/dev/disk/by-uuid/F1E0-AC24";
          fsType = "vfat";
          options = [
            "fmask=0077"
            "dmask=0077"
          ];
        };

        swapDevices = [
          { device = "/dev/mapper/vgroot-swap"; }
        ];

        nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
        hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

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

        boot.kernelPackages = pkgs.linuxPackages_latest;

        networking.hostName = "msi";

        networking.networkmanager.enable = true;

        time.timeZone = "Europe/Paris";

        i18n.defaultLocale = "en_US.UTF-8";
        console.keyMap = "us";

        environment.systemPackages = with pkgs; [
          sbctl
        ];

        system.stateVersion = "26.05";

      };

  };
}
