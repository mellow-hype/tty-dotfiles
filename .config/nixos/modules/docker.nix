{ config, pkgs, lib, variables, ... }:

let
    username = variables.username;
in

{
    users.users.${username}.extraGroups = ["docker"];

    environment.systemPackages = with pkgs; [
        docker
        docker-compose
    ];

    virtualisation.docker.enable = true;
}
