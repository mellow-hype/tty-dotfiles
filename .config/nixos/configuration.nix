# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
    imports =
        [ # Include the results of the hardware scan.
          /etc/nixos/hardware-configuration.nix
          /etc/nixos/modules/docker.nix
          /etc/nixos/modules/sway.nix
          /etc/nixos/modules/gui-common.nix
          /etc/nixos/modules/nvidia-sway.nix
          /etc/nixos/modules/custom-desktop.nix
        ];

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Enable networking
    networking.hostName = "nixos-tower"; # Define your hostname.
    networking.networkmanager.enable = true;

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

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.hyper = {
        isNormalUser = true;
        shell = pkgs.zsh;
        description = "hyper";
        extraGroups = [ "networkmanager" "wheel" "video" "docker" ];
        packages = with pkgs; [
            obsidian
        ];
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Install zsh
    programs.zsh.enable = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
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

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.05"; # Did you read the comment?

}
