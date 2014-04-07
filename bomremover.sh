#!/bin/bash
#
# BOMRemover v1.0
#
# (c) 2011, Adil Aliyev
# NEATS LLC 
# Baku/Azerbaijan
#
# adilaliev@gmail.com
#

function usage() {
    echo "BOMRemover v1.0"
    echo ""
    echo "(c) 2011, Adil Aliyev"
    echo ""
    echo "Usage:"
    echo "bomremover [-r] files..."
    echo "  -r    Scan subdirectories."
    echo ""
}

RECURSIVE_MODE=false

while getopts "rh" opt
do
    case $opt in
        r) RECURSIVE_MODE=true ;;
        h) usage; exit 1;;
        *) echo "Illegal option." ; exit 2 ;; 
    esac
done

FILES="$@"
if [ ! -n "$FILES" ] ; then
    echo "bomremover: No file specified"
    exit 1
fi 

color_greenf="\033[01;32m"
color_reset="\033[0m"

if [ $RECURSIVE_MODE == true ] ; then
    find . -type f | while read file
    do
        sed -i 's/^\xef\xbb\xbf//' "$file"
        echo -e "$file\t\t\t${color_greenf}done.${color_reset}";
    done
else
    for i in $FILES ; do
        sed -i 's/^\xef\xbb\xbf//' $i
        echo -e "$i\t\t\t${color_greenf}done.${color_reset}";
    done
fi
#EOF
