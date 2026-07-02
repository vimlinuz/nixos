#!/usr/bin/env nix-shell
#!nix-shell -i bash -p bash coreutils

# new-journal-entry.sh
# Creates today's journal entry at ~/Notes/creative/journal/<year>/<mon>/<day>.md
# following the structure already used in the journal directory, and seeds it
# with the template format (Start / Title / Mood / Body / Daily Log / End / Duration).

set -euo pipefail

JOURNAL_DIR="$HOME/Notes/creative/journal"

# --- Derive date pieces from the `date` command ---
year=$(date +%Y)
month=$(date +%b | tr '[:upper:]' '[:lower:]')   # jan, feb, mar, apr, may, jun, jul, ...
day=$(date +%d)

# Your existing tree uses "fev" instead of "feb" for February.
# Map any month abbreviations you want to keep custom here.
declare -A MONTH_MAP=(
  [feb]="fev"
)
month="${MONTH_MAP[$month]:-$month}"

target_dir="$JOURNAL_DIR/$year/$month"
target_file="$target_dir/$day.md"

# --- Create directory if missing ---
mkdir -p "$target_dir"

# --- Create file from template if it doesn't already exist ---
if [[ -f "$target_file" ]]; then
  echo "Entry already exists: $target_file"
else
  start_time=$(date "+%a, %d %b %Y %H:%M:%S %z")

  cat > "$target_file" <<EOF
Start: $start_time
Title: "Option<Here goes the title of specific topic that I am going to talk about>"
Mood: <mood>

---

# <contents of the title>

---

# Daily Log

## <contents of the daily log>

End: <time when I am going to end this journal entry>
Duration: <duration of this journal entry>
EOF

  echo "Created: $target_file"
fi

# --- Open it in your editor ---
"${EDITOR:-vi}" "$target_file"
