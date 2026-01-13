{...}: {
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = ["*"];
      settings = {
        main = {
          # Home row mods (GACS order for Workman)
          # overloadt: tap within timeout → key, hold past timeout + other key → modifier
          a = "overloadt(meta, a, 250)";
          s = "overloadt(alt, s, 250)";
          d = "overloadt(control, d, 250)";
          f = "overloadt(shift, f, 250)";
          j = "overloadt(shift, j, 250)";
          k = "overloadt(control, k, 250)";
          l = "overloadt(alt, l, 250)";
          ";" = "overloadt(meta, ;, 250)";
          # Caps Lock → Escape
          capslock = "esc";
        };
      };
    };
  };
}
