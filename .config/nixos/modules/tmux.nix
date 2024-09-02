{ config, pkgs, ... }:

{
    programs.tmux = {
        enable = true;
        newSession = true;
        shortcut = "a";
        baseIndex = 1;
        escapeTime = 0;
        keyMode = "vi";
        terminal = "tmux-256color";
        customPaneNavigationAndResize = true;
        resizeAmount = 10;
        aggressiveResize = true;
        historyLimit = 100000;
        extraConfig = ''
            # set window split
            bind-key v split-window -h
            bind-key b split-window

            # pane navigation without prefix key
            bind -n M-h select-pane -L
            bind -n M-j select-pane -D
            bind -n M-k select-pane -U
            bind -n M-l select-pane -R

            # quickly jump between last pane/window
            bind-key C-a last-window
            bind-key C-z last-pane

            # mouse mode for resizing
            set -g mouse on

            # new window with name
            bind-key C command-prompt -p "Name of new window: " "new-window -n '%%'"
        '';
    };
}
