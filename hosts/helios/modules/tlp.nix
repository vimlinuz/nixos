{
  services.tlp = {
    enable = true;
    settings = {

      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 40;

      # sudo tlp-stat -b
      # See https://linrunner.de/tlp/settings/bc-vendors.html
      START_CHARGE_THRESH_BAT0 = 0; # dummy value
      STOP_CHARGE_THRESH_BAT0 = 1;
    };
  };
}
