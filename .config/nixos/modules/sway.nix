{ config, pkgs, lib, variables, ... }:

{
    imports = [ /etc/nixos/modules/gui-common.nix ];

    # set the video driver to use (in case nvidia doesn't want to play nice with sway)
    services.xserver.videoDrivers = lib.mkIf variables.useNvidia [
        "nvidia"
    ];

    # set up greetd + tuigreet
    services.greetd = {
        enable = true;
        settings = {
            default_session.command = ''
                ${pkgs.greetd.tuigreet}/bin/tuigreet \
                --time \
                --asterisks \
                --remember \
                --greeting "welcome back" \
                --cmd 'sway ${if variables.useNvidia then "--unsupported-gpu" else ""}'
          '';
        };
    };

    environment.etc."greetd/environments".text = ''
      sway
    '';

    # install sway and other common gui packages
    environment.systemPackages = with pkgs; [
        swaylock
        swayidle
        wl-clipboard
        grim
        slurp
        foot
        kanshi
        fuzzel
        dmenu
        dunst
        dex
        gammastep
        i3status
        feh
        wdisplays
    ];

    # enable sway and set up the environment a bit
    programs.sway = {
        enable = true;
        wrapperFeatures.gtk = true;
        extraSessionCommands = ''
          export MOZ_ENABLE_WAYLAND=1
          export _JAVA_AWT_WM_NONREPARENTING=1
          export QT_QPA_PLATFORM=wayland
          export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
          export SDL_VIDEODRIVER=wayland
          export WLR_DRM_DEVICES="/dev/dri/card1:/dev/dri/card0"
          export WLR_NO_HARDWARE_CURSORS=1
          export XWAYLAND_NO_GLAMOR=1
        '';
    };

    environment.sessionVariables = {
        XDG_CURRENT_DESKTOP = "sway";
    };

    # systemd user services for kanshi
    systemd.user.services.kanshi = {
        description = "kanshi daemon";
        serviceConfig = {
            Type = "simple";
            ExecStart = ''${pkgs.kanshi}/bin/kanshi -c /home/${variables.username}/.config/kanshi/config'';
        };
    };

    # systemd user services for gammastep
    systemd.user.services.gammastep = {
        description = "gammastep daemon";
        serviceConfig = {
            Type = "simple";
            ExecStart = ''
                ${pkgs.gammastep}/bin/gammastep -c /home/${variables.username}/.config/gammastep/config.ini
            '';
        };
    };

    # Enable Polkit
    security.polkit.enable = true;
}
