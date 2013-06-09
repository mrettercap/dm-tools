#!/bin/bash

usage() {
    echo "Usage: $0 [options] [theme]"
    echo
    echo "Options"
    echo "  -l   List available themes"
    echo "  -s   Show all themes"
    echo "  -h   Get this help message"
    exit 1
}

about() {
   echo "All about us!"
   exit 1
}

while getopts ":lsha" Option
do
   case $Option in
     l ) echo "Listy" ;;
     s ) echo "Themes" ;;
     h ) usage ;;
     a ) about ;;
     * ) usage ;;
   esac
done
