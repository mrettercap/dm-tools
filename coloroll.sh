#!/bin/bash 

########################################
#				       # 
#   ROLL.SH // Dice Roll Script.       #
#   --------------------------------   #
#   For DMs. Part of dm-tools suite.   #
#        by Benjamin M. Ford           #
#   				       #
#   + Jun 2013			       #
#				       #
########################################

# Syntax: roll {die modifier} {sides to die}  
#     eg: roll 3d20 


# Store the colors in variables for easy printing.
yellow="\033[0;93m"
purple="\033[0;95m"
blue="\033[1;34m"
grey="\033[0;90m"
underline="$( tput sgr 0 1 )"
nullcolor="tput sgr0"


# Color echo function. Makes things a little easier
ecol() {
	printf "$1"
	shift
	printf "$@"
	$nullcolor
}

# How do we use this damn thing?
usage() {
     # Rolla boy tell 'em
     printf "Usage: $0 "
     ecol $yellow "3"
     ecol $purple "d20"
     echo
     exit 0
}

# This is our rolling function
roll() {
  # Starting a for loop that goes from 1 to however many dice are specified in the roll modifier
  for index in $(eval echo {1..$1})
  do
     # For each number of dice, generate a random number between 1 and the number of sides to the die, then add to an array.
     ROLLS[$index]=$[ ( $RANDOM % $2 ) +1 ]
  done  
  
  # Then, unpack the array. 
  for rnum in "${ROLLS[@]}"
  do
     # We want to make our overall roll the sum of each of the rolls.
     let ROLL=$[ $ROLL + $rnum ]
  done

  # Start printing...
  printf "* " 

  # Printing colors
  ecol $yellow "$1" 			# 3
  ecol $purple "d$2"			#  d20
  ecol $blue ": "			#     :
  ecol $underline "$ROLL"		#       30
  ecol $blue "."			#	  .
  
  # If it's a multi-roll, show our working!
  [[ "$1" -gt 1 ]] && ecol $grey " (${ROLLS[*]})" # ( 10 5 15 )
 
  # And a newline for legibility.
  echo 

}

# Are we rolling in the right format?
case $1 in
     # If we receive input in the format of ./roll NxN, ./roll NNxN, or ./roll NxNN, break up the roll modifier and test for damage modifiers.
     [1-9]d[1-9]|[1-9][0-9]d[1-9]|[1-9]d[1-9][0-9]|[1-9]d[1-9][0-9][0-9]|[1-9][0-9]d[1-9][0-9]|[1-9][0-9]d[1-9][0-9][0-9]) roll "${1%d*}" "${1##*d}" ;;
     # ./roll d20 is OK too.
     d[1-9]|d[1-9][0-9]|d[1-9][0-9][0-9]) roll 1 "${1##*d}" ;;
     # as is ./roll 5.
     [1-9]|[1-9][0-9]|[1-9][0-9][0-9]) roll 1 $1 ;;
     # If we get some other crazy input, though, show 'em the usage. 
     *) usage ;;
esac

# That's all, folks.
