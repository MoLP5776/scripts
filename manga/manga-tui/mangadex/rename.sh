#!/bin/bash

###########################################
# USER SETTINGS
###########################################

# Set this per series
TRANSLATOR="anonymous"
REMOVE_TRANSLATOR="_a_nonymous"  # What to REMOVE from original filenames
HAS_TITLE=true        # Set to false if series has no chapter titles

# Destination folder (edit for your setup)
DEST="/media/molp5776/E Festplatte A/Manga/Mairimashita! Iruma-kun"

###########################################
# SCRIPT START
###########################################

mkdir -p "$DEST"

for f in *.cbz; do
    original="$f"
    base="${f%.cbz}"

    # Remove Mangadex UUID
    pre_uuid=$(echo "$base" | sed 's/ [a-f0-9]\{8\}-[a-f0-9]\{4\}-[a-f0-9]\{4\}-[a-f0-9]\{4\}-[a-f0-9]\{12\}$//')

    ###########################################
    # Extract chapter with decimal support
    ###########################################
    chapter=$(echo "$pre_uuid" | grep -oP 'Ch[\. ]+\K[0-9]+(\.[0-9]+)?')

    if [[ "$chapter" == *.* ]]; then
        main_ch=${chapter%%.*}
        sub_ch=${chapter#*.}
        chapter_padded=$(printf "%04d.%s" "$main_ch" "$sub_ch")
    else
        chapter_padded=$(printf "%04d" "$chapter")
    fi

    # Remove "Ch X Vol Y"
    remainder=$(echo "$pre_uuid" | sed 's/^Ch [0-9]\+\(\.[0-9]\+\)\? Vol [^ ]\+ //')

    # Remove translator string
    if [[ -n "$REMOVE_TRANSLATOR" ]]; then
        remainder=$(echo "$remainder" \
            | sed "s/[ ]*$REMOVE_TRANSLATOR[ ]*//Ig" \
            | sed 's/  */ /g; s/^ //; s/ $//')
    fi

    # Title part
    if [[ "$HAS_TITLE" = true && -n "$remainder" ]]; then
        title_part=" - $remainder"
    else
        title_part=""
    fi

    # Translator tag
    if [[ -n "$TRANSLATOR" ]]; then
        translator_part=" [$TRANSLATOR]"
    else
        translator_part=""
    fi

    newname="Ch. $chapter_padded$title_part (en)$translator_part.cbz"

    echo "Renaming:"
    echo "   $original"
    echo "   → $newname"

    mv "$original" "$newname"
    mv "$newname" "$DEST/"
done
