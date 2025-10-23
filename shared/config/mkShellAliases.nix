name: let
  common = {
    ".." = "cd ../";
    "..." = "cd ../../";
    "...." = "cd ../../../";
    "....." = "cd ../../../../";

    h = "hx";
    "h." = "hx .";

    g = "git";
    glog = "git log --oneline";
    gb = "git branch";
    gba = "git branch -a";
    gco = "git checkout";
    gcob = "git checkout -b";
    gsw = "git switch";
    gf = "git fetch --prune";
    gs = "git status -s";
    gsr = "git status";
    ga = "git add -A";
    gp = "git push";
    gu = "git push --set-upstream origin HEAD";
    gl = "git pull";
    nuke = "git checkout -f HEAD && git clean -xdf";

    lg = "lazygit";
    dush = "du -sh";

    fetch = "nitch"; # to not change my mustle memory

    claer = "clear";
    cl = "clear";

    sl = "ls";
    lsa = "ls -a";
    la = "ls -a";
    ls = "ez";
    ez = "eza --icons --group-directories-first";
    l = "clear";

    flake = "nix flake";
    hs = "nh home switch";
    hb = "nh home build";
    home = "home-manager";
    nixgc = "nix-collect-garbage";
    rbs = "nh os switch";
    rbb = "nh os boot";
    rbbb = "nh os boot && reboot";
    rbt = "nh os test";
    yz = "yazi";

    sd = "shutdown";
  };

  bash = {
    cg = "cd $(git root)";
    sizeof = "du -sh";
    dush = "du -sh";
    gsv = "git status -v | diff-so-fancy | less --tabs=4 -RF";
    gd = "git diff --color-words | diff-so-fancy | less --tabs=4 -RF";
    nixman = "cd /etc/nixos/; sudo -s;";
  };

  nushell = {
    cg = "cd (git root)";
  };
in
  # standard aliases for POSIX
  if name == "bash" || name == "fish"
  then common // bash
  else if name == "nushell"
  then common // nushell
  else throw "Unknown shell: ${name}"
