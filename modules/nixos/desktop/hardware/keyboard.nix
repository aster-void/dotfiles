{...}: {
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = ["*"];
      settings = {
        main = {
          # Home row mods (GACS order for Workman)
          # overloadt: tap within timeout → key, hold past timeout + other key → modifier
          a = "overloadt(meta, a, 150)";
          s = "overloadt(alt, s, 150)";
          d = "overloadt(control, d, 150)";
          f = "overloadt(shift, f, 150)";
          j = "overloadt(shift, j, 150)";
          k = "overloadt(control, k, 150)";
          l = "overloadt(alt, l, 150)";
          ";" = "overloadt(meta, ;, 150)";
          # Caps Lock → Escape
          capslock = "esc";
        };
      };
    };
  };
}
