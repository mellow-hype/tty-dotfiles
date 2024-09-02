{ config, lib, pkgs, variables, ... }:

{
    imports = [
        /etc/nixos/modules/variables.nix
        /etc/nixos/modules/user.nix
        /etc/nixos/modules/tmux.nix
    ];

    # common variables
    variables.username = "hyper";
    variables.editor = "nvim";

    # Enable networking
    networking.hostName = variables.hostname; # Define your hostname.
    networking.networkmanager.enable = variables.useNetworkManager;

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

    # neovim
    programs.neovim = {
        enable = true;
        defaultEditor = true;
        vimAlias = true;
    };

    # Install common applications
    programs.git.enable = true;
    programs.zsh.enable = true;
    programs.htop.enable = true;

    # other common packages
    environment.systemPackages = with pkgs; [
        ripgrep
        jq
        fzf
        bat
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
        curl
        wget
        file
        killall
        unzip
    ];

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
}
