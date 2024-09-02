{ config, lib, pkgs, variables, ... }:

{
    users.users.${variables.username} = {
        isNormalUser = true;
        shell = pkgs.zsh;
        description = "${variables.username}";
        extraGroups = [ "networkmanager" "wheel" "video" "docker" ];
        packages = variables.userPkgs;
        openssh.authorizedKeys.keys = variables.sshPubKey;
    };
}
