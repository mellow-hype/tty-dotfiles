{ config, lib, pkgs, ... }:

{
    imports =
        [ # Include the results of the hardware scan.
          /etc/nixos/hardware-configuration.nix
          # common stuff
          /etc/nixos/modules/common.nix
          /etc/nixos/modules/user-hyper.nix
          # GUI
          /etc/nixos/modules/gui-common.nix
          /etc/nixos/modules/sway.nix
          /etc/nixos/modules/nvidia-sway.nix
          # other
          /etc/nixos/modules/docker.nix
        ];

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Enable networking
    networking.hostName = "nixos-tower"; # Define your hostname.
    networking.networkmanager.enable = true;

    environment.systemPackages = with pkgs; [
        # control commander pro fans
        liquidctl
        lm_sensors
    ];

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.05"; # Did you read the comment?
}
