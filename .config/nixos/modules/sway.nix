{ config, pkgs, lib, ... }:

let
  username = "hyper";
in {
    services.greetd = {
        enable = true;
        settings = {
            default_session.command = ''
                ${pkgs.greetd.tuigreet}/bin/tuigreet \
                --time \
                --asterisks \
                --remember \
                --greeting "welcome back" \
                --cmd 'sway --unsupported-gpu'
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
        # media
        mpv
        moc
    ];

    programs.sway = {
        enable = true;
        wrapperFeatures.gtk = true;
        extraSessionCommands = ''
          export MOZ_ENABLE_WAYLAND=1
          export _JAVA_AWT_WM_NONREPARENTING=1
          export QT_QTA_PLATFORM=wayland
          export SDL_VIDOEDRIVER=wayland
        '';
    };

    systemd.user.services.kanshi = {
        description = "kanshi daemon";
        serviceConfig = {
            Type = "simple";
            ExecStart = ''${pkgs.kanshi}/bin/kanshi -c /home/${username}/.config/kanshi/config'';
        };
    };

    systemd.user.services.gammastep = {
        description = "gammastep daemon";
        serviceConfig = {
            Type = "simple";
            ExecStart = ''
                ${pkgs.gammastep}/bin/gammastep -c /home/${username}/.config/gammastep/config.ini
            '';
        };
    };

    environment.sessionVariables = {
        XDG_CURRENT_DESKTOP = "sway";
    };

    # Enable Polkit
    security.polkit.enable = true;
}
