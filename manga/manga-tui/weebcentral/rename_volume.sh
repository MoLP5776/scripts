#!/bin/bash

###########################################
# USER SETTINGS (EDIT THESE PER SERIES)
###########################################

TRANSLATOR=""                       # Optional
REMOVE_TRANSLATOR=""                # Remove from source filename if present
DEST="/media/molp5776/E Festplatte A/Manga/MARRIAGETOXIN"

###########################################
# SCRIPT START
###########################################

mkdir -p "$DEST"

for f in *.cbz; do
    original="$f"
    base="${f%.cbz}"

    # Remove WeebCentral UUID
    pre_uuid=$(echo "$base" | sed 's/ [A-Z0-9]\{12,40\}$//')

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

    # Remove "Ch N Vol X"
    remainder=$(echo "$pre_uuid" | sed 's/^Ch [0-9]\+\(\.[0-9]\+\)\? Vol [^ ]\+ //')

    # Optional translator removal
    if [[ -n "$REMOVE_TRANSLATOR" ]]; then
        remainder=$(echo "$remainder" \
            | sed "s/[ ]*$REMOVE_TRANSLATOR[ ]*//Ig" \
            | sed 's/  */ /g; s/^ //; s/ $//')
    fi

    ###########################################
    # Volume release = add (en)
    ###########################################
    newname="Ch. $chapter_padded (en) [$TRANSLATOR].cbz"

    echo "Renaming:"
    echo "  $original"
    echo "    → $newname"

    mv "$original" "$newname"
    mv "$newname" "$DEST/"
done

