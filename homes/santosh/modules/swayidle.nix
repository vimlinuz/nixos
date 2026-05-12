{ pkgs, ... }:
{
  services.swayidle = {
    enable = true;
    events = {
      lock = "hyprlock";
      after-resume = "niri msg action power-on-monitors";
      before-sleep = "hyprlock";
    };
    timeouts = [
      {
        timeout = 185;
        command = "niri msg action power-off-monitors";
      }
      {
        timeout = 300;
        command = "hyprlock";
      }
      {
        timeout = 600;
        command = "${pkgs.systemd}/bin/systemctl suspend-then-hibernate";
      }
    ];
  };
}
