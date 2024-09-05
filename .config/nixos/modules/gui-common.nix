
{ config, pkgs, lib, variables, ... }:

{
    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    # Enable sound with pipewire.
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    services.libinput.enable = true;

    # Install firefox.
    programs.firefox = {
        enable = true;
        package = pkgs.firefox-bin;
    };

    # other gui packages
    environment.systemPackages = with pkgs; [
        # media
        mpv
        moc
    ];

    # Install common GUI packages under user scope
    users.users.${variables.username} = {
        packages = with pkgs; [
            obsidian
        ];
    };

    # Install fonts
    fonts.packages = with pkgs; [
        terminus_font
        nerdfonts
        powerline-fonts
    ];

    # Install 1Password CLI and GUI
    programs._1password.enable = true;
    programs._1password-gui.enable = true;
}
