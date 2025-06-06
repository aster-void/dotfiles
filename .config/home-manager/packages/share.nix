{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    localsend

    # Development

    act
    postgresql
    wget
    bat
    xh
    tokei
    stow
    eza

    ## Nix

    hydra-check

    ## Langservers

    biome
    typescript-language-server
    tailwindcss-language-server
    svelte-language-server
    clippy
    metals # scala
    astro-language-server
    hyprls
    bash-language-server
    nil
    nixd
    alejandra
    statix
    glsl_analyzer
    emmet-ls
    typstyle
    fixjson

    ## terminal multiplexer
    zellij

    ## Text Editor
    inputs.helix.packages.${system}.default
    # helix

    ## git tools
    gh
    tig
    diff-so-fancy

    # dep graph
    cargo-depgraph
    graphviz
  ];
}
