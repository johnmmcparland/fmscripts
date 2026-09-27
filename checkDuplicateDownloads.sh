#!/bin/bash
###############################################################################
## Check Duplicate Downloads
# Remove files from DF11PureMegapackWomen
# which duplicate existing ones in CutoutFaces
# Similarly, count duplicates between MetallicLogos and TCMLogos
###############################################################################

# Constants
GAME_NAME="FMBackups"

# Main Directories
GRAPHICS_DIR="${USERPROFILE}/Documents/Sports Interactive/${GAME_NAME}/graphics"
DF11_DIR="${GRAPHICS_DIR}/DF11PureMegapackWomen"
CUTOUT_FACES_DIR="${GRAPHICS_DIR}/CutoutFaces/faces"
CUTOUT_ICONS_DIR="${GRAPHICS_DIR}/CutoutFaces/iconfaces"
METALLIC_LOGOS="${GRAPHICS_DIR}/MetallicLogos"
METALLIC_LOGOS_CLUBS="${METALLIC_LOGOS}/clubs"
MY_LOGOS="${GRAPHICS_DIR}/MyLogos"

DUPLICATES_DIR=duplicates

# Duplicate files
UNIQUE_FACES="${DUPLICATES_DIR}/df11_faces_unique.txt"
UNIQUE_ICONS="${DUPLICATES_DIR}/df11_icons_unique.txt"
DUPLICATE_FACES="${DUPLICATES_DIR}/df11_faces_duplicates.txt"
DUPLICATE_ICONS="${DUPLICATES_DIR}/df11_icons_duplicates.txt"

if [[ ! -d ${DUPLICATES_DIR} ]];then 
  mkdir -p ${DUPLICATES_DIR}
 fi

if [[ -f ${UNIQUE_FACES} ]];then 
  rm ${UNIQUE_FACES}
fi

if [[ -f ${DUPLICATE_FACES} ]];then 
  rm ${DUPLICATE_FACES}
fi 

if [[ -f ${UNIQUE_ICONS} ]];then 
  rm ${UNIQUE_ICONS}
fi

if [[ -f ${DUPLICATE_ICONS} ]];then 
  rm ${DUPLICATE_ICONS}
fi 

# Find facs in DF11_DIR that are already in CUTOUT_DIR
for FILE in `ls "${DF11_DIR}" | grep -i png`;do 
   if [[ -f "${CUTOUT_FACES_DIR}/face_${FILE}" ]];then
     echo "${FILE}" >> ${DUPLICATE_FACES}
	 rm "${DF11_DIR}/${FILE}"
   else
     echo "${FILE}" >> ${UNIQUE_FACES}
   fi
done 

# Find icons in DF11_DIR that are already in CUTOUT_DIR
for FILE in `ls "${DF11_DIR}" | grep -i png`;do 
   if [[ -f "${CUTOUT_ICONS_DIR}/iconface_${FILE}" ]];then
     echo "${FILE}" >> ${DUPLICATE_ICONS}
	 rm "${DF11_DIR}/${FILE}"
   else
     echo "${FILE}" >> ${UNIQUE_ICONS}
   fi
done 

echo "Unique Faces: ": 
wc -l ${UNIQUE_FACES}
echo ""
echo "Duplicate Faces: ": 
wc -l ${DUPLICATE_FACES}
echo ""

echo "Unique Icons: ": 
wc -l ${UNIQUE_ICONS}
echo ""
echo "Duplicate Icons: ": 
wc -l ${DUPLICATE_ICONS}
echo ""

echo "Run FM Graphics Configurator v1.2 on DF11 now"

# French Club Logos
