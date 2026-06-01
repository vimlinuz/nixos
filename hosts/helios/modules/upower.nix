{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    upower.enable = lib.mkEnableOption "Enable upower (power actions service)";
  };
  config = lib.mkIf config.upower.enable {
    environment.systemPackages = [
      # https://github.com/omeid/upower-notify
      # need to run this by the use of wm on startup
      # pkgs.upower-notify
    ];
    services.upower = {
      enable = true;
      percentageAction = 2;
      percentageLow = 20;
      percentageCritical = 10;
      criticalPowerAction = "Hibernate";
      allowRiskyCriticalPowerAction = true;
    };
  };
}
