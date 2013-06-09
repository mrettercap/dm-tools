#!/bin/bash 

# Dice roller for Tabletops.
# by Benjamin Ford

# Syntax: roll {die modifier} {sides to die}  
#     eg: roll 3d20 

# How do we use this damn thing?
usage() {
     # Rolla boy tell 'em
     echo "Usage: $0 {roll modifier}d{number of sides to die}"
     echo "eg. $0 3d20"
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

  # Print the number of sides to the die as well as the dice modifier.
  printf "* \033[0;93m$1\033[0;95md$2\033[1;34m:\033[00m "

  # Print the outcome of the dice roll(s).
  printf  "\033[00m$ROLL\033[00m\033[1;34m.\033[00m" 
  
  # If it's a multi-roll, show our working!
  [[ "$1" -gt 1 ]] && echo -e " \033[0;90m(${ROLLS[@]})\033[00m" || echo

}

# Are we rolling in the right format?
case $1 in
     # If we receive input in the format of ./roll NxN, ./roll NNxN, or ./roll NxNN, break up the roll modifier and test for damage modifiers.
     [1-9]d[0-9]|[1-9][0-9]d[0-9]|[1-9]d[0-9][0-9]|[1-9]d[0-9][0-9][0-9]|[1-9][0-9]d[0-9][0-9]|[1-9][0-9]d[0-9][0-9][0-9]) roll "${1%d*}" "${1##*d}" ;;
     # ./roll d20 is OK too.
     d[1-9]|d[1-9][0-9]|d[1-9][0-9][0-9]) roll 1 "${1##*d}" ;;
     # as is ./roll 5.
     [1-9]|[1-9][0-9]|[1-9][0-9][0-9]) roll 1 $1 ;;
     # If we get some other crazy input, though, show 'em the usage. 
     *) usage ;;
esac
