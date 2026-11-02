{
  pkgs,
  ...
}:
let
  blink = pkgs.writeShellScript "blink" ''
    LED=/sys/class/leds/input10::capslock/brightness
    echo "blink daemon started at"

    # Here int might not require but any way
    trap 'echo "blink daemon stopped"; exit 0' TERM INT

    while true; do
      printf 1 > "$LED"
      echo "LED on"
      sleep 0.2

      printf 0 > "$LED"
      echo "LED off"
      sleep 0.2
    done
  '';
in
{
  systemd = {
    sleep.settings.Sleep = {
      HibernateDelaySec = "20min";
    };

    # services.capslock-blink = {
    #   description = "Blink the capslock LED";
    #   wantedBy = [ "multi-user.target" ];
    #   serviceConfig = {
    #     ExecStart = "${blink}";
    #     Restart = "always";
    #     User = "root";
    #   };
    # };

  };
}
