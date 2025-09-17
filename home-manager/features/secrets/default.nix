{
  inputs,
  config,
  ...
}: let
  inherit (config.age) secrets;
in {
  imports = [
    inputs.agenix.homeManagerModules.age
  ];

  age.secrets.github-public-access-token.file = ../../../secrets/github/public-access-token.age;

  programs.fish.shellInit = ''
    # Convert brace-style env refs to fish-compatible
    set -l __gh_secret_path "${builtins.replaceStrings ["{" "}"] ["" ""] secrets.github-public-access-token.path}"

    # Set GITHUB_TOKEN if the secret is available; otherwise, do nothing.
    if test -r "$__gh_secret_path"
      set -gx GITHUB_TOKEN (cat "$__gh_secret_path")
    end
  '';

  # Bash: guard secret read and export if present
  programs.bash.bashrcExtra = ''
    __gh_secret_path="${builtins.replaceStrings ["{" "}"] ["" ""] secrets.github-public-access-token.path}"
    if [ -r "$__gh_secret_path" ]; then
      export GITHUB_TOKEN="$(cat "$__gh_secret_path")"
    fi
  '';

  # Zsh: same guard as bash
  programs.zsh.initExtra = ''
    __gh_secret_path="${builtins.replaceStrings ["{" "}"] ["" ""] secrets.github-public-access-token.path}"
    if [ -r "$__gh_secret_path" ]; then
      export GITHUB_TOKEN="$(cat "$__gh_secret_path")"
    fi
  '';
}
