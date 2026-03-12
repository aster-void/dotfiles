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

# Abbreviations
abbr .. "cd ../"
abbr ... "cd ../../"
abbr .... "cd ../../../"
abbr ..... "cd ../../../../"

abbr h hx
abbr h. "hx ."

abbr g git
abbr gf "git fetch --prune"
abbr gs "git status -s"
abbr gp "git push"
abbr gl "git pull"
abbr gsv "git diff --cached"
abbr gd "git diff"
abbr lg lazygit

abbr claer clear
abbr cl clear

alias ls="eza --icons --group-directories-first"
abbr sl ls
abbr l ls

abbr flake "nix flake"
abbr home home-manager
abbr nixgc nix-collect-garbage
abbr yz yazi
abbr zel zellij
abbr sd shutdown

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
