{ config, lib, pkgs, ... }:

{
    # Define hyper user account (should have been created during install but now we set some other
    # stuff)
    users.users.hyper = {
        isNormalUser = true;
        shell = pkgs.zsh;
        description = "hyper";
        extraGroups = [ "networkmanager" "wheel" "video" "docker" ];
        packages = with pkgs; [
            obsidian
        ];
    };
}
