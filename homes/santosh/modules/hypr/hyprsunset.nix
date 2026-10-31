{
  services.hyprsunset = {
    enable = true;
  };

  home.file.".config/hypr/hyprsunset.conf".text = ''
    max-gamma = 150

    profile {
        time = 6:00
        temperature = 6000
        gamma = 1
    }

    profile {
        time = 18:00
        temperature = 4500
        gamma = 1
    }

    profile {
        time = 22:00
        temperature = 3000
        gamma = 1
    }
  '';
}
