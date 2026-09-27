#!/bin/bash

# This script finds every config.xml file under the current directory
# and renames it to backup_config_xml in the same directory.
# See also restoreGraphicConfigs.sh


# Main Directories
GRAPHICS_DIR="graphics/TCMLogos"

find "${GRAPHICS_DIR}" -type f -name "config.xml" -exec sh -c '
for file do
    dir=$(dirname "$file")
    mv "$file" "$dir/backup_config_xml"
done
' sh {} +
