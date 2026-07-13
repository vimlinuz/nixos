{
  pkgs,
  lib,
  ...
}:
let
  yt-dlp = "${lib.getExe pkgs.yt-dlp}";
  pull = pkgs.writeShellScriptBin "pull" ''
    #!/usr/bin/env bash

    URL="$1"
    MODE="$2"

    if [[ "$MODE" == "--help" ]] || [[ -z "$URL" ]] || [[ "$URL" == "--help" ]] || [[ "$URL" == "--music" ]] || [[ "$URL" == "--video" ]]; then
      echo "Usage: pull <url> <mode>"
      echo "Modes:"
      echo "  --music: download music"
      echo "  --video: download video"
      exit 0;
    fi

    if [[ "$MODE" == "--music" ]]; then
      ${yt-dlp} -x --audio-format mp3 "$URL"
      exit 0;
    fi

    if [[ "$MODE" == "--video" ]] || [[ -z "$MODE" ]]; then
      ${yt-dlp} --merge-output-format mp4 -f "bestvideo+bestaudio/best" "$URL"
      exit 0;
    fi
  '';
in
{
  home.packages = [
    pull
  ];
}
