{ config, lib, pkgs, variables, ... }:

{
    # host specific variables
    variables.username = "hyper";
    variables.hostname = "nixos-tower";
    variables.videoDrivers = ["nouveau"];
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
    hardware.opengl.enable = true;

    # machine-specific packages
    environment.systemPackages = with pkgs; [
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
