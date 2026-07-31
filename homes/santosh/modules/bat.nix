{ pkgs, ... }:
{
  programs.bat = {
    enable = true;
    themes = {
      catppuccin = {
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "6810349b28055dce54076712fc05fc68da4b8ec0";
          sha256 = "sha256-lJapSgRVENTrbmpVyn+UQabC9fpV1G1e+CdlJ090uvg=";
        };
        file = "themes/Catppuccin Mocha.tmTheme";
      };

      vauge = {
        src = pkgs.fetchFromGitHub {
          owner = "vague-theme";
          repo = "vague-bat";
          rev = "0d3f25c1eb443fa6a4f11cf34f05b11a3514376f";
          sha256 = "sha256-sYiiiKTOcCD7D/s8HdjEezBylZndw4JGkm/FZceQw50=";
        };
        file = "vague.tmTheme";
      };

    };
    config = {
      theme = "vague";
    };
  };

}
