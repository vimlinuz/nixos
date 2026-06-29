{ pkgs, inputs }:
with pkgs;
[
  ffmpeg
  brightnessctl
  playerctl
  ripgrep

  # vscode
  gimp
  code-cursor

  opencode
  opencode-desktop

  obs-studio
  vlc
  mpv
  swaybg
  libreoffice
  microfetch
  zip
  # Provided via flake inputs (not nixpkgs).
  # inputs.quickshell.packages.${stdenv.hostPlatform.system}.default
  inputs.qml-niri.packages.${stdenv.hostPlatform.system}.quickshell
  inputs.crane-rs.packages.${stdenv.hostPlatform.system}.default
  # inputs.mdwatch.packages.${stdenv.hostPlatform.system}.default
  mdwatch
]
