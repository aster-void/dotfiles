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

    ## terminal multiplexer

    zellij

    ## Text Editor

    inputs.helix.packages.${system}.default
  ];
}
