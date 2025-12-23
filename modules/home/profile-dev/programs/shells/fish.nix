{...}: let
  common = import ./common-aliases.nix;
  fishSpecific = {
    cg = "cd $(git root)";
    sizeof = "du -sh";
    nixman = "cd /etc/nixos/; sudo -s;";
  };
in {
  programs.fish = {
    enable = true;
    shellAliases = common // fishSpecific;
    interactiveShellInit = ''
      # NixOS doesn't set $SHELL from /etc/passwd in graphical sessions
      set -gx SHELL (command -v fish)
      set -g fish_greeting
      set -g __starship_fish_use_job_groups "false"

      function view
        if test (count $argv) -eq 0; or test "$argv[1]" = "-"
          command cat
          return
        end
        for arg in $argv
          switch $arg
            case -h --help
              echo "usage: view [file...]"; echo "  images: chafa, others: bat, stdin: cat"; return
            case '-*'
              echo "view: unknown flag: $arg" >&2; return 1
          end
        end
        for f in $argv
          if not test -e $f
            echo "view: $f: No such file" >&2; continue
          end
          switch (file --brief --mime-type $f)
            case 'image/*'
              chafa $f
            case '*'
              bat $f
          end
        end
      end

      # Auto-fetch and pull on cd into git repo
      function __git_auto_pull --on-variable PWD
        test -d .git; or return
        # fetch in background
        git fetch --quiet &>/dev/null &
        disown
        # check if behind and working tree is clean
        set -l behind (git rev-list --count HEAD..@{u} 2>/dev/null)
        if test "$behind" -gt 0 2>/dev/null
          if test -z "$(git status --porcelain 2>/dev/null)"
            echo "⬇ Pulling $behind commit(s)..."
            git pull --quiet
          else
            echo "⬇ $behind commit(s) behind (dirty tree, skipping pull)"
          end
        end
      end
    '';
  };
}
