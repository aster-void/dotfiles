{
 programs.helix = {
  enable = true;
  settings = {
    theme = "onedark";
    editor.cursor-shape = {
      normal = "block";
      insert = "bar";
      select = "underline";
    };
  };
  themes = {
    one-dark-pro-darker = {
      "inherits" = "onedarker";
      "ui.background" = { };
    };
  };
  # LSPs, do not write below this
  languages.language = [
  {
    name = "rust";
    auto-format = true;
  }
  {
    name = "go";
    auto-format = true;
  }
  {
    name = "javascript";
    auto-format = true;
  }
  {
    name = "jsx";
    auto-format = true;
  }
  {
    name = "nix";
    auto-format = true;
  }
  ];
}; 
}
