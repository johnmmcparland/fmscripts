#!/usr/bin/env bash
# Restore config.xml files previously renamed by disableGraphicConfigs.sh.
set -u

GRAPHICS_DIR="graphics/TCMLogos"
if [[ ! -d "$GRAPHICS_DIR" ]]; then
    echo "ERROR: Directory not found: $GRAPHICS_DIR" >&2
    exit 1
fi

find "$GRAPHICS_DIR" -type f -name backup_config_xml -print0 |
while IFS= read -r -d '' file; do
    restored="$(dirname "$file")/config.xml"
    if [[ -e "$restored" ]]; then
        echo "WARNING: $restored already exists; leaving $file unchanged" >&2
        continue
    fi
    mv -- "$file" "$restored" || exit 1
done
