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
    # symbol = " ";
    symbol = " ";
  };

  nodejs = {
    symbol = "󰎙 ";
    style = "bold green";
  };
  bun = {
    symbol = "󰞈 Bun ";
    style = "bold pink";
  };

  c = {
    symbol = " ";
    style = "bold blue";
  };

  python = {
    symbol = "[p](blue)[y](yellow) ";
  };

  nix_shell = {
    format = "on [$symbol$state( \($name\))]($style) ";
    symbol = "󱄅 ";
  };

  git_status = {
    format = "([< $ahead_behind $all_status>]($style) )";
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
