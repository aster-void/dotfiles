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
          a = "lettermod(meta, a, 150, 200)";
          s = "lettermod(alt, s, 150, 200)";
          d = "lettermod(control, d, 150, 200)";
          f = "lettermod(shift, f, 150, 200)";
          j = "lettermod(shift, j, 150, 200)";
          k = "lettermod(control, k, 150, 200)";
          l = "lettermod(alt, l, 150, 200)";
          ";" = "lettermod(meta, ;, 150, 200)";
          # Caps Lock → Escape
          capslock = "esc";
        };
      };
    };
  };
}
