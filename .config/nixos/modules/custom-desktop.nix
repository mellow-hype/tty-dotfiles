{ config, pkgs, lib, ... }:

{
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
}
