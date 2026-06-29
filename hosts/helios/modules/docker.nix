{ config, lib, ... }:
{
  options = {
    docker.enable = lib.mkEnableOption "Enable docker";
  };

  config = lib.mkIf config.docker.enable {

    virtualisation.docker.enable = true;
    # users.users.santosh.extraGroups = [ "docker" ];

    virtualisation.docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };

  };
}
