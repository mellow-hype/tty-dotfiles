{ config, pkgs, lib, ... }:

{
    environment.systemPackages = with pkgs; [
        # control commander pro fans
        liquidctl
        lm_sensors
    ];
}
