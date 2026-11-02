{
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main = {
          capslock = "overload(control, esc)";
        };
        # Optional: adjust timing (default is usually fine)
        global = {
          overload_tap_timeout = "200"; # milliseconds
        };
      };
    };
  };
}
