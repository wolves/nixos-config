{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    shortcut = "a";
    baseIndex = 1;
    keyMode = "vi";
    terminal = "xterm-256color";

    plugins = with pkgs.tmuxPlugins; [
      better-mouse-mode
      online-status
      pain-control
    ];

    extraConfig = ''
      set-option -g renumber-windows on

      set -g message-style 'bg=default,fg=yellow,bold'

      set -g set-titles on
      set -g set-titles-string '#{window_index}.#{pane_index} ☞ #{pane_current_command}'

      set -g prefix C-a
      bind C-a send-prefix

      unbind '"'
      unbind %
      unbind C-b
      unbind -T copy-mode-vi MouseDragEnd1Pane
      unbind -T copy-mode-vi y

      # Copy mode bindings
      bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "wl-copy" \; display-message "highlighted selection copied to system clipboard"
      bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "wl-copy" \; display-message "highlighted selection copied to system clipboard"
      bind-key -T copy-mode-vi v send-keys -X begin-selection
    '';
  };
}
