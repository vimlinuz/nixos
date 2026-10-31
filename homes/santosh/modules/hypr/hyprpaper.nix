{ ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = true;
      splash_offset = 1.2;
      ipc = true;
      preload = [
        # "${config.home.homeDirectory}/nixos/wallpapers/anime-night-sky-illustration.jpg"
        # "${config.home.homeDirectory}/nixos/wallpapers/nix-dark.png"
      ];

      wallpaper = [
        # "DP-3,/share/wallpapers/buttons.png"
        # "eDP-1,${config.home.homeDirectory}/nixos/wallpapers/anime-night-sky-illustration.jpg"
      ];
    };
  };
}
