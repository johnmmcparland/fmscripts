#!/bin/bash

# Constants
GAME_NAME="FMBackups"

# Main Directories
GRAPHICS_DIR="${USERPROFILE}/Documents/Sports Interactive/${GAME_NAME}/graphics"

### Directories
## Faces
# Sortitoutsi Cut Out Faces Megapack
export CUTOUT_FACES_DIR=${GRAPHICS_DIR}/CutoutFaces
# My own faces that I need to add
export MY_FACES_DIR="${GRAPHICS_DIR}/MyFaces"
# DF11 Pure Faces (Womens)
export DF11_PURE_FACES=${GRAPHICS_DIR}/DF11PureMegapackWomen

## Logos
# Sortitoutsi Metallic Logos Megapack
export METALLIC_LOGOS_DIR=${GRAPHICS_DIR}/MetallicLogos
# My Logos
export MY_LOGOS=${GRAPHICS_DIR}/MyLogos

# Check for clashes in MyFaces 
for FILE in `ls "${MY_FACES_DIR}" | grep png`;do
    echo "Checking Face $FILE"
    if [[ -f ${CUTOUT_FACES_DIR}/faces/face_${FILE} ]];then
	    echo "Cutout Hit: Addition of ${FILE} is not required!"
	fi
	
	# There are still some faces 
	if [[ -f ${DF11_PURE_FACES}/${FILE} ]];then
	    echo "DF11Pure Hit: Addition of ${FILE} is not required!"
	fi
done;

# Check for clashes in MyLogos 
for FILE in `ls "${MY_LOGOS}" | grep png`;do
    echo "Checking Logo $FILE"
    if [[ -f ${METALLIC_LOGOS_DIR}/logos/clubs/normal/${FILE} ]];then
	    echo "Metallic 'logos/clubs/normal' Hit: Addition of ${FILE} is not required!"
	fi
	if [[ -f ${METALLIC_LOGOS_DIR}/logos/${FILE} ]];then
	    echo "Metallic 'logos' Hit: Addition of ${FILE} is not required!"
	fi
done;
