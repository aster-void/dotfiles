{
  add_newline = true;
  palette = "aster";
  palettes.aster = {
    pink = "#FFC1CC"; # bubble pink
    mustard = "#af8700";
  };

  golang = {
    symbol = " ";
    style = "cyan";
  };

  rust = {
    symbol = " ";
  };

  gleam = {
    symbol = " ";
  };

  nodejs = {
    symbol = "󰎙 ";
    style = "bold green";
    detect_extensions = [];
    detect_files = ["yarn.lock" "package-lock.json" ".nvmrc"];
    detect_folders = [];
  };
  bun = {
    symbol = " ";
    style = "bold pink";
  };

  java = {
    symbol = " ";
    detect_files = ["pom.xml" "build.gradle.kts" ".java-version" "deps.edn" "project.clj" "build.boot" ".sdkmanrc"];
  };
  scala = {
    symbol = " ";
    style = "red dimmed";
  };

  c = {
    symbol = " ";
    style = "bold blue";
  };

  python = {
    symbol = "[p](blue)[y](yellow) ";
  };

  nix_shell = {
    format = "in [$symbol$state( \($name\))]($style) ";
    symbol = "󱄅 ";
  };

  git_status = {
    format = "([< $ahead_behind $all_status>]($style) )";
    style = "yellow";

    conflicted = "<=>";
    ahead = "^";
    behind = "v";
    stashed = "stash";
    modified = "*";
    staged = "+";
    renamed = ">";
    deleted = "d";
  };

  directory = {
    truncation_length = 4;
    read_only = " [readonly]";
    read_only_style = "yellow bold";
    repo_root_style = "blue";
  };
}
