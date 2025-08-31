{
  common = {
    ".." = "cd ../";
    "..." = "cd ../../";
    "...." = "cd ../../../";
    "....." = "cd ../../../../";

    # n = "nvim";
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
    gc = "git commit -m";
    gp = "git push";
    gu = "git push --set-upstream origin HEAD";
    gl = "git pull";

    lg = "lazygit";

    fetch = "nitch"; # to not change my mustle memory

    claer = "clear";
    cl = "clear";

    sl = "ls";
    lsa = "ls -a";
    la = "ls -a";
    ls = "ez";
    ez = "eza --icons --group-directories-first";
    l = "clear";

    hs = "home-manager switch";
    hb = "home-manager switch";
    home = "home-manager";
    nixgc = "nixos-collect-garbage";

    zoom-us = "flatpak run us.zoom.Zoom";
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
}
