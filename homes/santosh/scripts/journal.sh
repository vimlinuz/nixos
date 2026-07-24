#!/usr/bin/env nix-shell
#!nix-shell -i bash -p bash coreutils

# new-journal-entry.sh
# Creates today's journal entry at ~/Notes/creative/journal/<year>/<mon>/<day>.md
# following the structure already used in the journal directory, and seeds it
# with the template format (Start / Title / Mood / Body / Daily Log / End / Duration).

set -euo pipefail

CURRENT_DIR=$(pwd)

JOURNAL_DIR="$HOME/Notes/creative/journal"
DO_CIW=true

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

# --- Capture start time ---
start_epoch=$(date +%s)
start_time=$(date -d "@$start_epoch")

# --- Create file from template if it doesn't already exist ---
if [[ -f "$target_file" ]]; then
  echo "Entry already exists: $target_file"
  DO_CIW=false
else

  cat > "$target_file" <<EOF
Start: $start_time

Title: "Option<Here goes the title of specific topic that I am going to talk about>"

Mood: <mood>

---

# <contents of the title>

---

# Daily Log

## <contents of the daily log>

EOF

  echo "Created: $target_file"
fi

# --- Open it in your editor ---
if $DO_CIW; then
  "${EDITOR:-vi}" -c "set spell" -c "call cursor(2, 9)"  -c "normal ci\"" "$target_file"
else
  "${EDITOR:-vi}" -c "set spell" "$target_file"
fi


# Set the end timestamp
end_epoch=$(date +%s)
end_time=$(date -d "@$end_epoch")
elapsed=$(( (end_epoch - start_epoch + 30) / 60 ))

# --- Append session info to the file
{
  echo "---"
  if ! $DO_CIW; then
    echo "Start: $start_time"
  fi
  echo "End: $end_time"
  echo "Duration: ${elapsed}min"
} >> "$target_file"

# --- Commit and push to github
cd "$JOURNAL_DIR"
jj commit -m "journal: $(date)"
jj bookmark move main --to @-; jj git push --bookmark main

cd "$CURRENT_DIR"
