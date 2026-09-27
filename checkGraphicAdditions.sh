#!/usr/bin/env bash
# Check whether personal face and logo additions already exist in downloaded packs.
set -u

GAME_NAME="FMBackups"
GRAPHICS_DIR="${USERPROFILE:?USERPROFILE is not set}/Documents/Sports Interactive/$GAME_NAME/graphics"
CUTOUT_FACES_DIR="$GRAPHICS_DIR/CutoutFaces"
MY_FACES_DIR="$GRAPHICS_DIR/MyFaces"
DF11_PURE_FACES="$GRAPHICS_DIR/DF11PureMegapackWomen"
METALLIC_LOGOS_DIR="$GRAPHICS_DIR/MetallicLogos"
MY_LOGOS="$GRAPHICS_DIR/MyLogos"

check_files() {
    local source=$1 label=$2
    shift 2
    if [[ ! -d "$source" ]]; then
        echo "WARNING: Directory not found: $source" >&2
        return
    fi
    local file
    while IFS= read -r -d '' file; do
        local name
        name=$(basename "$file")
        echo "Checking $label $name"
        for target in "$@"; do
            if [[ -f "$target/$name" ]]; then
                echo "  Hit: $target/$name"
            fi
        done
    done < <(find "$source" -maxdepth 1 -type f -iname '*.png' -print0)
}

check_files "$MY_FACES_DIR" Face "$CUTOUT_FACES_DIR/faces" "$DF11_PURE_FACES"
check_files "$MY_LOGOS" Logo "$METALLIC_LOGOS_DIR/logos/clubs/normal" "$METALLIC_LOGOS_DIR/logos"
