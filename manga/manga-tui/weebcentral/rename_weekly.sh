#!/bin/bash

###########################################
# USER SETTINGS
###########################################

# WeebCentral never has a translator in its name
# You can set one, but won't be included in filename
TRANSLATOR=""
DEST="/media/molp5776/E Festplatte A/Manga/MARRIAGETOXIN"

###########################################
# SCRIPT START
###########################################

mkdir -p "$DEST"

for f in *.cbz; do
    original="$f"
    base="${f%.cbz}"

    # Remove UUID
    pre_uuid=$(echo "$base" | sed 's/ [A-Z0-9]\{16,40\}$//')

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

    newname="Ch. $chapter_padded.cbz"

    echo "Renaming: $original → $newname"

    mv "$original" "$newname"
    mv "$newname" "$DEST/"
done

