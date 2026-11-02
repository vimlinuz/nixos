{
  pkgs,
  ...
}:
let
  # image = pkgs.fetchurl {
  #   url = "https://raw.githubusercontent.com/dharmx/walls/refs/heads/main/architecture/a_bridge_with_lights_on_it.jpg";
  #   sha256 = "465390cba5d4fa1861f2948b59fabe399bd2d7d53ddd6c896b0739bee4eca2c8";
  # };
  # theme = pkgs.stdenv.mkDerivation {
  #   name = "sddm-theme";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "MarianArlt";
  #     repo = "sddm-sugar-dark";
  #     rev = "ceb2c455663429be03ba62d9f898c571650ef7fe";
  #     sha256 = "0153z1kylbhc9d12nxy9vpn0spxgrhgy36wy37pk6ysq7akaqlvy";
  #   };
  #   installPhase = ''
  #     mkdir -p $out
  #     cp -R ./* $out/
  #     cd $out/
  #     rm Background.jpg
  #     cp -r ${image} $out/Background.jpg
  #   '';
  # };
  sddm-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "hyprland_kath";
    # themeConfig = {
    #   AccentColor = "#746385";
    #   FormPosition = "left";
    #
    #   ForceHideCompletePassword = true;
    # };
  };
in
{
  environment.systemPackages = [ sddm-astronaut ];

  services = {
    xserver.enable = true;

    displayManager = {
      sddm = {
        wayland.enable = true;
        enable = true;
        package = pkgs.kdePackages.sddm;

        theme = "sddm-astronaut-theme";

        extraPackages = [ sddm-astronaut ];
      };
      autoLogin = {
        enable = false;
        user = "santosh";
      };
    };
  };
}
