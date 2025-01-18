{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    # Development

    act
    postgresql
    svelte-language-server
    wget

    # he won't allow me install nix shell on that repo
    bun

    ## Nix

    hydra-check

    ## Langservers

    biome
    typescript-language-server
    tailwindcss-language-server
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
  ];
}
