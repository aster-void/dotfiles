{...}: {
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = ["*"];
      settings = {
        global = {
          overload_tap_timeout = 200;
        };
        main = {
          # Home row mods (GACS order for Workman)
          # overload + overload_tap_timeout: tap → key, hold past timeout → modifier only
          a = "overload(meta, a)";
          s = "overload(alt, s)";
          d = "overload(control, d)";
          f = "overload(shift, f)";
          j = "overload(shift, j)";
          k = "overload(control, k)";
          l = "overload(alt, l)";
          ";" = "overload(meta, ;)";
          # Caps Lock → Escape
          capslock = "esc";
        };
      };
    };
  };
}
