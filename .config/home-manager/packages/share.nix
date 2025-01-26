{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    # Development

    act
    postgresql
    wget
    bat

    ## Nix

    hydra-check

    ## Langservers

    biome
    typescript-language-server
    javascript-typescript-langserver
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

    ## terminal multiplexer
    zellij

    ## Text Editor
    inputs.helix.packages.${system}.default

    ## git tools
    tig
  ];
}
