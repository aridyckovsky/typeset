#!/bin/bash
#
# script for generating the print pdfs
# this script should be called from the Makefile in the document root
#
# check number of arguments with `$# -eq 0`
#

if [ $# == 2 ]; then
    echo "Changing directory to: $1"
    cd $1
    if [ $2 = 'true' ]; then
        echo "12345: $XELATEX_OPTS"
        echo -e "\n------------------ xelatex --------------------\n"     
        xelatex $XELATEX_OPTS main #|grep --ignore-case --extended-regex "info|warning|error|^\([A-Za-z0-9]*\)"
        echo -e "\n------------------- biber ---------------------\n" 
        biber $BIBER_OPTS main
        # echo -e "\n--------------- makeglossaries ----------------\n"         
        # makeglossaries main
        echo -e "\n------------------ xelatex --------------------\n" 
        xelatex $XELATEX_OPTS main > /dev/null
    else
        xelatex $XELATEX_OPTS main > /dev/null  
        biber $BIBER_OPTS main > /dev/null          
        # makeglossaries main > /dev/null   
        xelatex $XELATEX_OPTS main > /dev/null
    fi
else
    echo "Number of arguments given: $#"
    echo "Usage: ./screen.sh path_to_build_dir [true/false]"
fi
