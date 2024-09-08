{ config, lib, pkgs, variables, ... }:

{
    # host specific variables
    variables.hostname = "nixos-tower";
    variables.useNetworkManager = true;

    # host-specific user packages
    variables.userPkgs = with pkgs; [ ];

    imports =
        [ # Include the results of the hardware scan.
          /etc/nixos/hardware-configuration.nix
          # setup
          /etc/nixos/modules/common.nix
          /etc/nixos/modules/docker.nix
          # gui
          /etc/nixos/modules/sway.nix
          /etc/nixos/modules/nvidia.nix
        ];

    # bootloader
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # =====================================================================
    # --- SERVICES
    # =====================================================================
    # ssh server setup
    services.openssh = {
        enable = true;
        settings.PermitRootLogin = "no";
        settings.PasswordAuthentication = false;
    };

    # =====================================================================
    # --- APPLICATIONS
    # =====================================================================
    # machine-specific packages
    environment.systemPackages = with pkgs; [
        liquidctl
        lm_sensors
    ];

    # =====================================================================
    # --- AUTOMOUNT STORAGE
    # =====================================================================
    # Mount custom filesystems
    fileSystems."/media/hypercore/core" =
    { device = "/dev/disk/by-uuid/72cb7022-7fcb-4d7b-bd94-4a89da1a8c18";
      fsType = "ext4";
    };
    fileSystems."/media/hypercore/personal" =
    { device = "/dev/disk/by-uuid/7da69fe4-b5c7-460e-8d8a-4bdccdf685ae";
      fsType = "ext4";
    };
    fileSystems."/media/hypercore/media" =
    { device = "/dev/disk/by-uuid/7a959e34-0822-418d-8af7-540e982e748a";
      fsType = "ext4";
    };

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.05"; # Did you read the comment?
}
