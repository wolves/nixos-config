{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    shortcut = "a";
    baseIndex = 1;
    keyMode = "vi";
    terminal = "tmux-256color";

    plugins = with pkgs.tmuxPlugins; [
      better-mouse-mode
      {
        plugin = online-status;
        extraConfig = ''
          set -g @online_icon  "#[fg=brightgreen,none] #[default]"
          set -g @offline_icon "#[fg=red,none] #[default]"
        '';
      }
      pain-control
    ];

    extraConfig = ''
      set -ag terminal-overrides ",xterm-256color:RGB"
      set-option -g  status-keys vi 
      set-option -g  set-clipboard on
      set-option -g renumber-windows on

      set -g message-style 'bg=default,fg=yellow,bold'
      set -g status-style  'bg=default'

      # Title Style
      set -g set-titles on
      set -g set-titles-string '#{window_index}.#{pane_index} ☞ #{pane_current_command}'

      # Mode Style
      setw -g mode-style 'bg=green, fg=black, bold'

      # Status Line
      set -g status-interval 4    
      set -g status-position bottom

      ## Status Right
      set -g  status-right "#[bg=default,fg=brightblue] #{?$PATH_OVERFLOW,$PANE_SHORTENED_PATH,$TMUX_PANE_HOME_SHORTENED_PATH} "
      set -ga status-right "#[fg=brightblack]#U@#[bold]#H #{online_status}"
      set -g status-right-length 150

      ## Status Left
      set -g  status-left '#[fg=#000000,bold,bg=green]#{pane_mode}#[fg=green,none]'
      set -ga status-left '#{?client_prefix,#[bg=#d65c0d],#[bg=default]} #[fg=brightwhite,bold]#S#[fg=none] '
      set -ga status-left '#[bg=default]#{?client_prefix,#[fg=#d65c0d] ,#[fg=default]  }'
      set -g status-left-length 80

      # Window Status
      setw -g window-status-activity-style fg=yellow 
      setw -g window-status-bell-style     fg=red
      setw -g window-status-format         "#[fg=yellow]#I#[fg=green]#F #[fg=white]#W"
      setw -g window-status-current-format "#[fg=brightyellow]#I#[fg=brightgreen]#F #[fg=brightwhite,bold,underscore]#W"
      setw -g window-status-separator      "#[fg=brightwhite,bold]  "
      set -g status-justify left

      # Key-Bindings
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
