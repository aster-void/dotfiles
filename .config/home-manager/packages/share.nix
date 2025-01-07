{ pkgs, inputs, ... }: {
  home.packages = with pkgs;  [
    # Development

    act
    postgresql
    svelte-language-server
    wget

    ## Langservers

    biome
    typescript-language-server
    tailwindcss-language-server
    clippy
    metals # scala
    astro-language-server
    hyprls
    bash-language-server

    ## terminal multiplexer

    zellij

    ## Text Editor

    inputs.helix.packages.${system}.default
  ];
}
