{
  pkgs,
  ...
}:
let
  vague-yazi-flavor = pkgs.fetchFromGitHub {
    owner = "vague-theme";
    repo = "vague.yazi";
    rev = "b44fd1d80938e9bae3f7d9314bee27f075ffa260";
    sha256 = "sha256-+OtyTDX9z0+IhrLa7gMVdP6yb/aOHgmKombMMzfori4=";
  };

in
{
  programs.yazi = {
    enable = true;
    shellWrapperName = "yy";
    enableBashIntegration = true;
    enableNushellIntegration = true;
    extraPackages = with pkgs; [
      glow
      ouch
    ];

    flavors.vague = vague-yazi-flavor;

    theme = {
      flavor.dark = "vague";
    };
  };
}
