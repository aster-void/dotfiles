{...}: {
  programs.tmux = {
    enable = true;
    mouse = true;
    baseIndex = 1;
    escapeTime = 0;
    historyLimit = 10000;
    clock24 = true;
    prefix = "C-Space";
    disableConfirmationPrompt = true;

    extraConfig = ''
      # Better split bindings
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"

      # New window in current path
      bind c new-window -c "#{pane_current_path}"

      # Reload config
      bind r source-file ~/.config/tmux/tmux.conf \; display "Config reloaded"

      # OSC 52 clipboard (works over SSH)
      set -g set-clipboard on
      bind -T copy-mode MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel

      # Status bar styling
      set -g status-style bg=default,fg=white
      set -g status-left "[#S] "
      set -g status-right "%H:%M"
      set -g window-status-current-style fg=cyan,bold

      # True color support
      set -g default-terminal "tmux-256color"
      set -ga terminal-overrides ",*256col*:Tc"
    '';
  };
}
