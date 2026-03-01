# PATH
fish_add_path -g ~/.local/bin
fish_add_path -g ~/.cache/.bun/bin

# Session variables
set -gx EDITOR hx
set -gx NIX_PATH nixpkgs=flake:nixpkgs
set -gx TERMINFO_DIRS "$HOME/.nix-profile/share/terminfo:/etc/terminfo:/lib/terminfo:/usr/share/terminfo"

# Early exit on non-interactive shell
if not status is-interactive
    return
end

# Disable greeting
set -g fish_greeting

# Disable DNF package search on unknown commands
function fish_command_not_found
    echo "fish: Unknown command: $argv[1]" >&2
end

# Aliases
alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../"
alias .....="cd ../../../../"

alias h="hx"
alias h.="hx ."

alias g="git"
alias gf="git fetch --prune"
alias gs="git status -s"
alias gp="git push"
alias gl="git pull"
alias gsv="git diff --cached"
alias gd="git diff"
alias lg="lazygit"

alias claer="clear"
alias cl="clear"

alias sl="ls"
alias ls="ez"
alias ez="eza --icons --group-directories-first"
alias l="ls"

alias flake="nix flake"
alias home="home-manager"
alias nixgc="nix-collect-garbage"
alias yz="yazi"
alias zel="zellij"
alias sd="shutdown"

# Tool integrations
fzf --fish | source
zoxide init fish | source
mise activate fish | source
direnv hook fish | source
starship init fish | source

# Ghostty shell integration
if set -q GHOSTTY_RESOURCES_DIR
    source "$GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish"
end

# Quickshell terminal integration (end4)
# Disabled: overrides Ghostty's color theme with wallpaper-based colors
# if test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt
#     cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
# end
