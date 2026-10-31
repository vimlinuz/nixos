{
  programs.noctalia = {
    enable = true;
    systemd.enable = true;

    settings = ./config.toml;
  };
}
