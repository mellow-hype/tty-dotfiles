{ config, pkgs, lib, ... }:

{
    environment.systemPackages = with pkgs; [
        docker
        docker-compose
    ];

    # Docker
    virtualisation.docker.enable = true;
}
