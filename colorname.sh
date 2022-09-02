#!/bin/bash
# Prequisities:
# brew install html-xml-utils
if [ -n "$1" ]
then
  # Get inputted hex color
  HEX=$(echo "${1}" | sed 's/#//')

  # Split hex in characters for printing the actual color via printf
  CHAR1=${HEX:0:1}
  CHAR2=${HEX:0:1}
  CHAR3=${HEX:2:1}
  CHAR4=${HEX:3:1}
  CHAR5=${HEX:4:1}
  CHAR6=${HEX:5:1}
  HEX_SPLIT=${CHAR1}${CHAR2}/${CHAR3}${CHAR4}/${CHAR5}${CHAR6}

  # Scrape color name from color-name.com
  COLORNAME=$(wget -qO- "https://www.color-name.com/hex/$HEX" | hxnormalize -x | hxselect ".color-code" | lynx -stdin -dump -nolist | sed 's/     //g' | sed -e "s/Color Name: //g")

  # Get CSS color code for the color name
  COLORNAME_CSS=$(echo $COLORNAME | awk '{print tolower($0)}' | sed 's/[()]//g' | tr ' ' '-')
  CSSVAR="--color-$COLORNAME_CSS: #$HEX;"

  # Print color in Terminal beautifully
  echo ""
  printf '\e]4;1;rgb:'"$HEX_SPLIT"'\e\\\e[31m██ = #'"$HEX"', '"$COLORNAME"'\e\\'

  # Reset colors
  # printf '\e[m'
  printf '\n'
  
  echo ""

else
  echo 'Usage: colorname 000000 or colorname "#000000"'
fi
