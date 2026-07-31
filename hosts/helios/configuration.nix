# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  pkgs,
  inputs,
  config,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./modules/sddm.nix
    ./modules/packages.nix
    ./modules/bluetooth.nix
    inputs.sops-nix.nixosModules.sops
    ./modules/tlp.nix
    ./modules/upower.nix
    ./modules/logind.nix
    ./modules/keyd.nix
    ./modules/systemd.nix
    ./modules/plymouth.nix
    ./modules/docker.nix
  ];

  sops.defaultSopsFile = ../../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

  # Bootloader.
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 20;
        consoleMode = "auto";
      };

      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };

      timeout = 5;
    };

    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "udev.log_level=3"
      "systemd.show_status=auto"
    ];
  };

  networking.hostName = "helios"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kathmandu";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.santosh = {
    isNormalUser = true;
    description = "Santosh Shrestha";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "audio"
    ];
    shell = pkgs.bash;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPEP4JsCAwBRTvHsIeruzVx93usGdU3D9Rx4KE/LWQ8s santosh@atlas"
    ];
    # shell = pkgs.nushell;
  };

  # Allow unfree packages
  nixpkgs.config = {
    allowBroken = false;
    allowUnfree = true;
  };

  # https://home-manager-options.extranix.com/?query=bash&release=master
  # The reason this is here is this docs
  environment.pathsToLink = [ "/share/bash-completion" ];
  programs.bash.enable = true;

  services.xserver.enable = true;
  services.libinput.touchpad.disableWhileTyping = true;

  programs.hyprland = {
    enable = false;
    withUWSM = true;
    # package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    xwayland.enable = true;
  };

  programs.niri = {
    enable = true;
  };

  hardware.graphics.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };

  services.dbus.enable = true;

  security.polkit.enable = true;

  # Enable Bluetooth and Blueman service
  bluetooth.enable = false;

  # Enable TLP for power management
  tlp.enable = true;

  # Enable upower for power actions
  upower.enable = false;

  # remap
  keyd.enable = true;

  # https://nix.dev/guides/faq#how-to-run-non-nix-executables
  programs.command-not-found.enable = true;
  programs.nix-ld.enable = true;

  programs.nix-ld.libraries = with pkgs; [ clang-tools ];

  #i18n.inputMethod.enable = "fcitx5";
  #i18n.inputMethod.fcitx5.addons= with pkgs;
  #[fcitx5-mozc];

  # Enable the systemd configuration.
  systemd.enable = true;

  # Enable the systemd logind service to manage user logins.
  logind.enable = true;

  plymouth.enable = true;

  docker.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ "santosh" ];
    };
  };
  # Fail2Ban is a service that bans hosts that cause multiple authentication errors.
  services.fail2ban.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    8080
    8081
  ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
