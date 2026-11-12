{ pkgs, inputs }:
with pkgs;
[
  ffmpeg
  brightnessctl
  playerctl
  ripgrep
  libnotify

  # vscode
  gimp
  code-cursor

  opencode-desktop

  obs-studio
  # vlc
  mpv
  # swaybg
  # libreoffice
  # microfetch
  zip

  texliveFull

  qview

  kdePackages.kdenlive
  thunar
  # Provided via flake inputs (not nixpkgs).
  inputs.crane-rs.packages.${stdenv.hostPlatform.system}.default
  inputs.mdwatch.packages.${stdenv.hostPlatform.system}.default
  # mdwatch
]
