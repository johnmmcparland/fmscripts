#!/usr/bin/env bash
# Rename config.xml files under graphics/TCMLogos so the game ignores them.
# Run restoreGraphicConfigs.sh to restore them.
set -u

GRAPHICS_DIR="graphics/TCMLogos"
if [[ ! -d "$GRAPHICS_DIR" ]]; then
    echo "ERROR: Directory not found: $GRAPHICS_DIR" >&2
    exit 1
fi

find "$GRAPHICS_DIR" -type f -name config.xml -print0 |
while IFS= read -r -d '' file; do
    backup="$(dirname "$file")/backup_config_xml"
    if [[ -e "$backup" ]]; then
        echo "WARNING: Backup already exists; leaving $file unchanged" >&2
        continue
    fi
    mv -- "$file" "$backup" || exit 1
done
