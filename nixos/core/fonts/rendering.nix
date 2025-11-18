{
  fonts = {
    fontconfig = {
      antialias = true;
      hinting.enable = false;
      subpixel.rgba = "rgb";
      gamma = 1.0;
      subpixel.lcdfilter = "light";
    };
    freetype.properties = {
      "cff:no-stem-darkening" = "0";
      "autofitter:no-stem-darkening" = "0";
      "autofitter:darkening-parameters" = "0 0 0 0";
    };
  };
}
