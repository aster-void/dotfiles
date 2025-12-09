{pkgs, ...}: {
  programs.cava = {
    enable = true;
    package = pkgs.cava;
    settings = {
      general = {
        bars = 64;
        framerate = 60;
      };
      input = {
        method = "pulse";
        source = "auto";
      };
      output = {
        method = "ncurses";
        style = "stereo";
      };
      color = {
        gradient = 1;
        gradient_count = 8;
        gradient_color_1 = "'#c8e3ff'";
        gradient_color_2 = "'#d3dfff'";
        gradient_color_3 = "'#d0daff'";
        gradient_color_4 = "'#b7c5ff'";
        gradient_color_5 = "'#b0b8ff'";
        gradient_color_6 = "'#c7c8ff'";
        gradient_color_7 = "'#bfb8ff'";
        gradient_color_8 = "'#c9b5ed'";
      };
      smoothing = {
        noise_reduction = 85;
        monstercat = 1;
        waves = 0;
        gravity = 120;
      };
      eq = {
        "1" = 0.8;
        "2" = 0.9;
        "3" = 1.0;
        "4" = 1.1;
        "5" = 1.2;
      };
    };
  };

  # Additional cava config files
  xdg.configFile = {
    "cava/bar.config".text = ''
      ## Configuration file for CAVA. Default values are commented out. Use either ';' or '#' for commenting.

      [general]
      autosens = 1
      # sensitivity = 2400

      bars = 24
      lower_cutoff_freq = 30
      # higher_cutoff_freq = 5000
      higher_cutoff_freq = 20000

      sleep_timer = 10

      [input]
      method = pulse

      [output]
      method = raw
      channels = mono
      data_format = ascii
      ascii_max_range = 6

      [smoothing]
      # Disables or enables the so-called "Monstercat smoothing" with or without "waves". Set to 0 to disable.
      # monstercat = 1
      waves = 1

      # Noise reduction, float 0 - 100. default 77
      # noise_reduction = 77
      noise_reduction = 5

      [eq]
      # This one is tricky. You can have as much keys as you want.
      # Remember to uncomment more than one key! More keys = more precision.
      # Look at readme.md on github for further explanations and examples.
      1 = 2 # bass
      2 = 2
      3 = 1 # midtone
      4 = 1
      5 = 1 # treble
    '';

    "cava/themes/solarized_dark".text = ''
      [color]
      background = '#001e26'
      foreground = '#708183'

      gradient = 1
      gradient_color_1 = '#268bd2'
      gradient_color_2 = '#6c71c4'
      gradient_color_3 = '#cb4b16'

      horizontal_gradient = 1
      horizontal_gradient_color_1 = '#586e75'
      horizontal_gradient_color_2 = '#b58900'
      horizontal_gradient_color_3 = '#839496'

      blend_direction = 'up'
    '';

    "cava/themes/tricolor".text = ''
      [color]
      horizontal_gradient = 1
      horizontal_gradient_color_1 = '#c45161'
      horizontal_gradient_color_2 = '#e094a0'
      horizontal_gradient_color_3 = '#f2b6c0'
      horizontal_gradient_color_4 = '#f2dde1'
      horizontal_gradient_color_5 = '#cbc7d8'
      horizontal_gradient_color_6 = '#8db7d2'
      horizontal_gradient_color_7 = '#5e62a9'
      horizontal_gradient_color_8 = '#434279'
    '';

    "cava/shaders/pass_through.vert".text = ''
      #version 330


      // Input vertex data, different for all executions of this shader.
      layout(location = 0) in vec3 vertexPosition_modelspace;

      // Output data ; will be interpolated for each fragment.
      out vec2 fragCoord;

      void main()
      {
          gl_Position =  vec4(vertexPosition_modelspace,1);
          fragCoord  = (vertexPosition_modelspace.xy+vec2(1,1))/2.0;
      }
    '';
  };
}
