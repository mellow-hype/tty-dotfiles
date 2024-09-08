{ config, pkgs, lib, variables, ... }:

let
    kanshi_config = "/home/${variables.username}/.config/kanshi/config";
    gamma_config = "/home/${variables.username}/.config/gammastep/config.ini";
    sway_cmd = "sway ${if variables.useNvidia then "--unsupported-gpu" else ""}";
in

{
    imports = [ /etc/nixos/modules/gui-common.nix ];

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
                --cmd '${sway_cmd}'
          '';
        };
    };

    environment.etc."greetd/environments".text = ''
      sway
    '';

    # enable sway and set up the environment a bit
    programs.sway = {
        enable = true;
        wrapperFeatures.gtk = true;
        extraPackages = with pkgs; [
            swaylock
            swayidle
            i3status
            wl-clipboard
            grim
            slurp
            foot
            feh
            kanshi
            fuzzel
            dmenu
            dunst
            dex
            gammastep
            wdisplays
            qt6.qtwayland
        ];
        extraSessionCommands = ''
          export MOZ_ENABLE_WAYLAND=1
          export _JAVA_AWT_WM_NONREPARENTING=1
          export QT_QPA_PLATFORM=wayland
          export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
          export SDL_VIDEODRIVER=wayland
          export WLR_DRM_DEVICES="/dev/dri/card1:/dev/dri/card0"
          export WLR_NO_HARDWARE_CURSORS=1
          export XWAYLAND_NO_GLAMOR=1
          ${if variables.useNvidia then ''
            export WLR_DRM_DEVICES="/dev/dri/card1:/dev/dri/card0"
            export WLR_RENDERER=vulkan
            export GBM_BACKEND=nvidia-drm
            export __GL_GSYNC_ALLOWED=0
            export __GL_VRR_ALLOWED=0
            export __GLX_VENDOR_LIBRARY_NAME=nvidia
          '' else ''''}
        '';
    };

    # Add gnome-keyring service
    services.gnome.gnome-keyring.enable = true;
    systemd.user.services.polkit-gnome-authentication-agent-1 = {
        description = "gnome polkit agent";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
            Type = "simple";
            ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
            Restart = "on-failure";
            RestartSec = 1;
            TimeoutStopSec = 10;
        };
    };

    environment.sessionVariables = {
        XDG_CURRENT_DESKTOP = "sway";
        NIXOS_OZONE_WL = "1";
    };

    # systemd user services for kanshi
    systemd.user.services.kanshi = {
        description = "kanshi daemon";
        serviceConfig = {
            Type = "simple";
            ExecStart = ''${pkgs.kanshi}/bin/kanshi -c ${kanshi_config}'';
        };
    };

    # systemd user services for gammastep
    systemd.user.services.gammastep = {
        description = "gammastep daemon";
        serviceConfig = {
            Type = "simple";
            ExecStart = ''
                ${pkgs.gammastep}/bin/gammastep -c ${gamma_config}
            '';
        };
    };

    # Enable Polkit
    security.polkit.enable = true;
}
