#!/bin/bash

# This script finds every backup_config.xml file under the current directory
# and renames it to config_xml in the same directory.
# See also disableGraphicConfigs.sh

# Main Directories
GRAPHICS_DIR="graphics/TCMLogos"

# Loop through all config.xml files under the graphics directory
find ${GRAPHICS_DIR} -type f -name "backup_config.xml" -exec sh -c '
for file do
    dir=$(dirname "$file")
    mv "$file" "$dir/config_xml"
done
' sh {} +
