#!/bin/bash

# Constants
GAME_NAME="Football Manager 26 Console"

# Main Directories
GRAPHICS_DIR=`cygpath ${USERPROFILE}/Documents/Sports Interactive/${GAME_NAME}/graphics`

### Directories
## Faces
# Sortitoutsi Cut Out Faces Megapack
export CUTOUT_FACES_DIR=${GRAPHICS_DIR}/CutoutFaces
# My own faces that I need to add
export MY_FACES_DIR=${CUTOUT_FACES_DIR}/MyFaces
# DF11 Pure Faces (Womens)
export DF11_PURE_FACES=${GRAPHICS_DIR}/DF11PureMegapackWomen

## Logos
# Sortitoutsi Metallic Logos Megapack
export METALLIC_LOGOS_DIR=${GRAPHICS_DIR}/MetallicLogos
# TCM Logos (Women)
export TCM_LOGOS_WOMEN=${GRAPHICS_DIR}/TCMLogos/Women
# My Logos
export MY_LOGOS=${GRAPHICS_DIR}/MyLogos

### Create the Directories
## Faces
if [[ ! -d ${CUTOUT_FACES_DIR} ]];then
   mkdir -p ${CUTOUT_FACES_DIR} 
fi

if [[ ! -d ${MY_FACES_DIR} ]];then
   mkdir -p ${MY_FACES_DIR} 
fi

if [[ ! -d ${DF11_PURE_FACES} ]];then
   mkdir -p ${DF11_PURE_FACES} 
fi

## Logos
if [[ ! -d ${METALLIC_LOGOS_DIR} ]];then
    mkdir -p ${METALLIC_LOGOS_DIR}
fi

if [[ ! -d ${TCM_LOGOS_WOMEN} ]];then
    mkdir -p ${TCM_LOGOS_WOMEN}
fi

if [[ ! -d ${MY_LOGOS} ]];then
    mkdir -p ${MY_LOGOS}
fi
