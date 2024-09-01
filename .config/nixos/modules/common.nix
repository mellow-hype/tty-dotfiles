{ config, lib, pkgs, ... }:

{
    # Set your time zone.
    time.timeZone = "America/Los_Angeles";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Install zsh
    programs.zsh.enable = true;

    # baseline common packages
    environment.systemPackages = with pkgs; [
        # editor
        neovim
        fzf
        ripgrep
        # dev
        coreutils
        binutils
        bc
        autoconf
        gcc
        gdb
        gnumake
        cmake
        python3Full
        bear
        # shell
        bat
        git
        tmux
        htop
        curl
        wget
        file
        killall
        unzip
    ];

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
}
