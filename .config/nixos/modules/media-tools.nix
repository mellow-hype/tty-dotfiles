

{ config, pkgs, lib, variables, ... }:

{
    # other gui packages
    environment.systemPackages = with pkgs; [
        # media
        mpv
        moc
        ffmpeg
        kid3
        kid3-cli
        shared-mime-info
    ];

    # packages to install under user scope
    users.users.${variables.username} = {
        packages = with pkgs; [
            yt-dlp
            clementine
        ];
    };
}
