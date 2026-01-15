{...}: {
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = ["*"];
      settings = {
        main = {
          # Home row mods (GACS order for Workman)
          # lettermod(layer, key, idle_timeout, hold_timeout)
          # - idle_timeout: if key pressed within this time after last key, output key immediately
          # - hold_timeout: otherwise, use overloadt2 behavior with this timeout
          a = "lettermod(meta, a, 100, 200)";
          s = "lettermod(alt, s, 100, 200)";
          d = "lettermod(control, d, 100, 200)";
          f = "lettermod(shift, f, 100, 200)";
          j = "lettermod(shift, j, 100, 200)";
          k = "lettermod(control, k, 100, 200)";
          l = "lettermod(alt, l, 100, 200)";
          ";" = "lettermod(meta, ;, 100, 200)";
          # Caps Lock → Escape
          capslock = "esc";
        };
      };
    };
  };
}
