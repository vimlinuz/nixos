{ pkgs, ... }:
{
  services.swayidle = {
    enable = true;
    events = {
      lock = "swaylock -fF";
      after-resume = "niri msg action power-on-monitors";
      before-sleep = "${pkgs.swaylock}/bin/swaylock -fF";
    };
    timeouts = [
      {
        timeout = 185;
        command = "niri msg action power-off-monitors";
      }
      {
        timeout = 300;
        command = "swaylock -fF";
      }
      {
        timeout = 600;
        command = "${pkgs.systemd}/bin/systemctl suspend-then-hibernate";
      }
    ];
  };
}
