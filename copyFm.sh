#!/bin/bash
###############################################################################
# Copy FM Console Cloud Files
# 3rd Nov 2025
#
# Based on what works on my own machine
# - Windows 11
# - FM 26 Console Game bought outright via Microsoft Store
# - Use Microsoft Account and XBox Account
# Tested on git bash alone
############################################################################### 

GAME_NAME="Football Manager 26 Console"

# Main Directories
WIN_LOCAL_DIR=`cygpath ${LOCALAPPDATA}`
WIN_LOCAL_LOW_DIR=`cygpath ${LOCALAPPDATA}Low`
WIN_USER_DIR=`cygpath ${USERPROFILE}`

# Local - for games, tactics, views (older ones), filters (older ones)
FM_LOCAL_DIR=${WIN_LOCAL_DIR}/Sports\ Interactive/${GAME_NAME}/Temporary

# Local Low - crash dumps, view (newer), filters (newer)
FM_LOCAL_LOW_DIR=${WIN_LOCAL_LOW_DIR}/Sports\ Interactive/${GAME_NAME}

# SI - where I want my stuff to start 
SI_DOCS_DIR=${WIN_USER_DIR}/Documents/Sports\ Interactive


if [[ 1 -ne ${#} ]];then
   echo "[ERROR] Please use a save name"
   exit 0
fi 

SAVE_NAME=${1}

FM_BACKUP_DIR=${SI_DOCS_DIR}/FMBackups/${GAME_NAME}/${SAVE_NAME}
FM_BACKUP_LOCAL_DIR=${FM_BACKUP_DIR}/Local
FM_BACKUP_LOCAL_LOW_DIR=${FM_BACKUP_DIR}/LocalLow

# Create Directories
if [[ ! -d "${FM_BACKUP_DIR}" ]];then   
  mkdir -p "${FM_BACKUP_DIR}"
else 
  echo "${FM_BACKUP_DIR} exists"
fi

if [[ ! -d "${FM_BACKUP_LOCAL_DIR}" ]];then
   mkdir -p "${FM_BACKUP_LOCAL_DIR}"
else 
  echo "${FM_BACKUP_LOCAL_DIR} exists"
fi

if [[ ! -d "${FM_BACKUP_LOCAL_LOW_DIR}" ]];then
   mkdir -p "${FM_BACKUP_LOCAL_LOW_DIR}"
else 
  echo "${FM_BACKUP_LOCAL_LOW_DIR} exists"
fi

# We should backup FM_LOCAL_DIR according to the name of the .fmt file

echo "Copying ${FM_LOCAL_DIR}"
cp -r -u -v "${FM_LOCAL_DIR}"/ "${FM_BACKUP_LOCAL_DIR}"/
echo ""

echo "Copying ${FM_LOCAL_LOW_DIR}"
cp -r -u -v "${FM_LOCAL_LOW_DIR}"/* "${FM_BACKUP_LOCAL_LOW_DIR}"/
echo ""

echo "Complete"
