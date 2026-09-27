#!/usr/bin/env bash
###############################################################################
# Copy Football Manager Console cloud-save files into a named backup.
# Tested with Git Bash on Windows 11 and the Microsoft Store version.
###############################################################################

set -u

GAME_NAME="Football Manager 26 Console"
if [[ $# -ne 1 || -z "$1" ]]; then
    echo "Usage: $0 <backup-name>" >&2
    exit 2
fi
if ! command -v cygpath >/dev/null 2>&1; then
    echo "ERROR: cygpath is required (run this script from Git Bash)." >&2
    exit 1
fi

WIN_LOCAL_DIR=$(cygpath -u "${LOCALAPPDATA:?LOCALAPPDATA is not set}")
WIN_LOCAL_LOW_DIR=$(cygpath -u "${USERPROFILE:?USERPROFILE is not set}/AppData/LocalLow")
WIN_USER_DIR=$(cygpath -u "$USERPROFILE")
FM_LOCAL_DIR="$WIN_LOCAL_DIR/Sports Interactive/$GAME_NAME/Temporary"
FM_LOCAL_LOW_DIR="$WIN_LOCAL_LOW_DIR/Sports Interactive/$GAME_NAME"
BACKUP_DIR="$WIN_USER_DIR/Documents/Sports Interactive/FMBackups/$GAME_NAME/$1"

if [[ ! -d "$FM_LOCAL_DIR" && ! -d "$FM_LOCAL_LOW_DIR" ]]; then
    echo "ERROR: Neither source directory exists; is the game installed or running?" >&2
    exit 1
fi
mkdir -p "$BACKUP_DIR/Local" "$BACKUP_DIR/LocalLow" || exit 1

copy_dir() {
    local source=$1 destination=$2
    if [[ -d "$source" ]]; then
        echo "Copying $source"
        cp -r -u -v "$source/." "$destination/" || return 1
    else
        echo "WARNING: Source directory not found: $source" >&2
    fi
}
copy_dir "$FM_LOCAL_DIR" "$BACKUP_DIR/Local" || exit 1
copy_dir "$FM_LOCAL_LOW_DIR" "$BACKUP_DIR/LocalLow" || exit 1
echo "Backup complete: $BACKUP_DIR"
