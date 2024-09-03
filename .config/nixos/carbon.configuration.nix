{ config, lib, pkgs, variables, ... }:

{
    # host specific variables
    variables.hostname = "carbon";
    variables.videoDrivers = [];
    variables.useNvidia = false;
    variables.useNetworkManager = true;

    # host-specific user packages
    variables.userPkgs = with pkgs; [ obsidian ];

    imports =
        [ # Include the results of the hardware scan.
          /etc/nixos/hardware-configuration.nix
          # setup
          /etc/nixos/modules/common.nix
          /etc/nixos/modules/docker.nix
          # gui
          /etc/nixos/modules/sway.nix
        ];

    # bootloader
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # enable OpenGL
    hardware.opengl = {
        enable = true;
        extraPackages = with pkgs; [
            onevpl-intel-gpu
            intel-vaapi-driver
            libvdpau-va-gl
        ];
    };

    # set up for Intel drivers+firmware
    hardware.enableAllFirmware = true;
    hardware.enableRedistributableFirmware = true;

    # setup auto unlock of secondary luks storage
    environment.etc.crypttab.text = ''
        hyprcrypt UUID=fab2649e-2880-4a75-9264-5d6cf8ec6a94  /root/core-luks.key    luks
    '';

    fileSystems."/media/hypercore/core" =
    { device = "/dev/mapper/hyper--vg-vred";
      fsType = "ext4";
    };

    fileSystems."/media/hypercore/personal" =
    { device = "/dev/mapper/hyper--vg-personal";
      fsType = "ext4";
    };

    fileSystems."/media/hypercore/media" =
    { device = "/dev/mapper/hyper--vg-media";
      fsType = "ext4";
    };

    # setup swapfile
    swapDevices = [{
        device = "/swapfile";
        size = 32 * 1024;
    }];

    # Install light for backlight control
    programs.light.enable = true;

    # machine-specific packages
    environment.systemPackages = with pkgs; [
    ];

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.05"; # Did you read the comment?
}
