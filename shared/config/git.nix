{
  core.editor = "hx";
  init.defaultBranch = "main";
  pull.rebase = "true";
  alias = {
    aa = "add -A";
    c = "commit";
    co = "checkout";
    sw = "switch";
    u = "push --set-upstream origin HEAD";
    lo = "log --oneline";
    ba = "branch --all";

    # semantic commands
    ls = "ls-files";
    graph = "log --graph --date-order -C -M --pretty=format:\"<%h> %ad [%an] %Cgreen%d%Creset %s\" --all --date=short";
    unstage = "reset HEAD --";
    root = "rev-parse --show-toplevel";
    last = "log -1 HEAD";
    nuke = "!git checkout -f HEAD && git clean -f";
    uncommit = "reset HEAD~";
    amend = "commit --amend --no-edit";
    recommit = "commit --amend";

    # headless-ready commands
    # modified version of <https://zenn.dev/kawarimidoll/articles/94fe6d900ed4d6>
    sync = "fetch --prune --all";
    detach = "switch --detach";
    behead = "!git fetch --prune --all --quiet && git switch -d $(git symbolic-ref refs/remotes/origin/HEAD)";
    name = ''!git switch --create ''$([[ -n "$1" ]] || echo "wip-$RANDOM")'';
    vacuum = "!git branch | grep -v --fixed-string '*' | xargs --no-run-if-empty git branch -d";
    restack = "!git refresh --quiet && git rebase $(git remote-head)";
  };
}
