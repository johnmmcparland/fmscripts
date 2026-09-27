#!/usr/bin/env bash
# Create the graphics-pack directories used by this setup.
set -u

GAME_NAME="Football Manager 26 Console"
if ! command -v cygpath >/dev/null 2>&1; then
    echo "ERROR: cygpath is required (run this script from Git Bash)." >&2
    exit 1
fi
GRAPHICS_DIR=$(cygpath -u "${USERPROFILE:?USERPROFILE is not set}/Documents/Sports Interactive/$GAME_NAME/graphics")

directories=(
    "$GRAPHICS_DIR/CutoutFaces"
    "$GRAPHICS_DIR/CutoutFaces/MyFaces"
    "$GRAPHICS_DIR/DF11PureMegapackWomen"
    "$GRAPHICS_DIR/MetallicLogos"
    "$GRAPHICS_DIR/TCMLogos/Women"
    "$GRAPHICS_DIR/MyLogos"
)
for directory in "${directories[@]}"; do
    mkdir -p "$directory" || exit 1
done
