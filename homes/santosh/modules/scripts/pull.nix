{
  pkgs,
  lib,
  ...
}:
let
  yt-dlp = lib.getExe pkgs.yt-dlp;
  pull = pkgs.writeShellScriptBin "pull" ''
    URL="$1"
    MODE="$2"

    if [[ "$MODE" == "--help" ]] || [[ -z "$URL" ]] || [[ "$URL" == "--help" ]]; then
      echo "Usage: pull <url> [--music|--video]"
      exit 0
    fi

    if [[ "$MODE" == "--music" ]]; then
      ${yt-dlp} -x --audio-format mp3 "$URL"
      exit 0
    fi

    if [[ "$MODE" == "--video" ]] || [[ -z "$MODE" ]]; then
      ${yt-dlp} --merge-output-format mp4 -f "bestvideo+bestaudio/best" "$URL"
      exit 0
    fi

    echo "Unknown mode: $MODE"
    echo "Use --help for usage."
    exit 1
  '';
in
{
  home.packages = [
    pull
  ];
}
