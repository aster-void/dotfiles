{

  common = {
    ".." = "cd ../";
    "..." = "cd ../../";
    "...." = "cd ../../../";
    "....." = "cd ../../../../";

    n = "nvim";
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


    sl = "ls";
    claer = "clear";

    hs = "home-manager switch";
    hypr = "cd ~/.config/hypr/; ls";
    hb = "home-manager switch";
    home = "home-manager";

    # zoom-us = "flatpak run us.zoom.Zoom";
    ccp = "cargo compete";
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
