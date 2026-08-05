{
  programs.cava = {
    enable = true;
    settings = {
      input = {
        method = "pipewire";
        source = "auto";
      };

      color = {
        # no background set: keep the terminal's (transparent) background
        # background = "'#141415'"; # vague black
        gradient = 1;
        gradient_color_1 = "'#6e94b2'"; # blue
        gradient_color_2 = "'#7e98e8'"; # iris
        gradient_color_3 = "'#aeaed1'"; # cyan
        gradient_color_4 = "'#bb9dbd'"; # magenta
        gradient_color_5 = "'#9bb4bc'"; # teal
        gradient_color_6 = "'#b4d4cf'"; # aqua
      };
    };
  };
}
