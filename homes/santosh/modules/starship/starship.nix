{ lib, ... }:
let
  voxel = import ./modules/voxel.nix { inherit lib; };
  prime = import ./modules/prime.nix { inherit lib; };
in
{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
    settings = prime.settings;
  };
}
