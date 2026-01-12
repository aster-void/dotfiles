{...}: {
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = ["*"];
      settings = {
        main = {
          # Home row mods (GACS order for Workman)
          # overloadt: tap within timeout → key, hold past timeout + other key → modifier
          a = "overloadt(meta, a, 100)";
          s = "overloadt(alt, s, 100)";
          d = "overloadt(control, d, 100)";
          f = "overloadt(shift, f, 100)";
          j = "overloadt(shift, j, 100)";
          k = "overloadt(control, k, 100)";
          l = "overloadt(alt, l, 100)";
          ";" = "overloadt(meta, ;, 100)";
          # Caps Lock → Escape
          capslock = "esc";
        };
      };
    };
  };
}
