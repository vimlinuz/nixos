{
  runCommandLocal,
  wall-archive,
  wallpkgs,
}:

# Merge the two wallpaper collections into one flat directory so Noctalia can
# browse them as a single set in every scan mode. The wall-archive filenames
# are prefixed to keep them from colliding with the (category-prefixed) names
# from wallpkgs.
runCommandLocal "wallpapers" { } ''
  mkdir -p $out/wallpapers

  link_wallpapers() {
    local src=$1
    local prefix=$2

    find "$src" -type f \
      \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' \
         -o -iname '*.gif' -o -iname '*.webp' \) \
      -print0 |
      while IFS= read -r -d "" file; do
        ln -s "$file" "$out/wallpapers/$prefix$(basename "$file")"
      done
  }

  link_wallpapers ${wall-archive}/wallpapers "archive-"
  link_wallpapers ${wallpkgs}/wallpapers ""

  echo "linked $(find $out/wallpapers -type l | wc -l) wallpapers"
''
