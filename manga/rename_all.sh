#!/bin/bash

# Base manga-tui download folder
BASE="$HOME/.local/share/manga-tui/mangaDownloads"

echo "===== Starting Rename ALL Batch ====="
echo ""

for series_dir in "$BASE"/*; do
    [[ ! -d "$series_dir" ]] && continue

    series_name=$(basename "$series_dir")
    eng_folder="$series_dir/English"

    echo "Processing: $series_name"

    # Check English folder
    if [[ ! -d "$eng_folder" ]]; then
        echo "  ❌ English folder missing → Skipping"
        echo ""
        continue
    fi

    # Check for CBZ files
    cbz_count=$(find "$eng_folder" -maxdepth 1 -type f -name "*.cbz" | wc -l)
    if [[ $cbz_count -eq 0 ]]; then
        echo "  ⚠️  No new chapters found"
        echo ""
        continue
    fi

    ###################################
    # Run EXACTLY ONE rename script
    ###################################
    if [[ -f "$eng_folder/rename_weekly.sh" ]]; then
        (
            cd "$eng_folder" || exit
            bash ./rename_weekly.sh
        )
        echo "  ✅ Weekly rename completed"

    elif [[ -f "$eng_folder/rename.sh" ]]; then
        (
            cd "$eng_folder" || exit
            bash ./rename.sh
        )
        echo "  📦 Rename completed"

    else
        echo "  ❌ No rename script found"
    fi

    echo ""
done

echo "===== Rename ALL Batch Finished ====="
