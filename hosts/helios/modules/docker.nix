{

  virtualisation.docker.enable = true;
  # users.users.santosh.extraGroups = [ "docker" ];

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
}
