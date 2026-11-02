{
  services.logind = {
    settings.Login = {

      # when the lid is closed
      # HandleLidSwitch = "suspend-then-hibernate";
      HandleLidSwitch = "ignore";
      # when multiple displays are connected
      lidSwitchDocked = "ignore";
      # when on external power and multiple displays are connected
      HandleLidSwitchExternalPower = "ignore";

      # idle settings
      IdleAction = "ignore";
      IdleActionSec = "600"; # 10 minutes

      # power button settings
      # HandlePowerKey = "hibernate";
      HandlePowerKey = "ignore";
      HandlePowerKeyLongPress = "poweroff";

      PowerKeyIgnoreInhibited = "no";
      LidSwitchIgnoreInhibited = "yes";

      # waits before executing actions
      HoldoffTimeoutSec = "30";
    };
  };
}
