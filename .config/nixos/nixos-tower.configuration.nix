{ config, lib, pkgs, variables, ... }:

{
    # host specific variables
    variables.hostname = "nixos-tower";
    variables.videoDrivers = ["nvidia"];
    variables.useNvidia = true;
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
          /etc/nixos/modules/nvidia.nix
        ];

    # bootloader
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # ssh server setup
    services.openssh = {
        enable = true;
        settings.PermitRootLogin = "no";
        settings.PasswordAuthentication = false;
    };

    # enable OpenGL
    hardware.opengl = {
        enable = true;
        driSupport = true;
        extraPackages = with pkgs; [
            vulkan-tools
            vulkan-validation-layers
            mesa
        ];
    };

    # make sway + nvidia play nicer
    programs.sway.extraSessionCommands = ''
        export WLR_DRM_DEVICES="/dev/dri/card1:/dev/dri/card0"
        export WLR_RENDERER=vulkan
        export GBM_BACKEND=nvidia-drm
        export __GL_GSYNC_ALLOWED=0
        export __GL_VRR_ALLOWED=0
        export __GLX_VENDOR_LIBRARY_NAME=nvidia
    '';

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
