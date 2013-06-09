#!/bin/bash 

# Dice roller for Tabletops.
# by Benjamin Ford

# Syntax: roll {die modifier} {sides to die}  
#     eg: roll 3d20 

# First arg: number of sides to the die!
DIE=$1

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
  printf "* \033[0;93m${MF}\033[0;95md$DIE\033[1;34m: "

  # If we're rolling multiple dice, print the individual rolls along with the total. Otherwise, just print the total.
  [[ "$1" -gt 1 ]] && echo -e "\033[00m${ROLLS[@]} \033[1;37m\033[104m Total: $ROLL \033[00m" || echo -e "\033[00m$ROLL\033[1;34m."


}

# Are we rolling in the right format?
case $DIE in
     # If we receive input in the format of ./roll NxN, ./roll NNxN, or ./roll NxNN, break up the roll modifier and test for damage modifiers.
     [1-9]d[0-9]|[1-9][0-9]d[0-9]|[1-9]d[0-9][0-9]|[1-9]d[0-9][0-9][0-9]|[1-9][0-9]d[0-9][0-9]|[1-9][0-9]d[0-9][0-9][0-9]) MF=${DIE%d*}; DIE=${DIE##*d}; roll "$MF" "$DIE" ;;
     d[1-9]|d[1-9][0-9]|d[1-9][0-9][0-9]) DIE=${DIE##*d}; roll 1 "$DIE" ;;
     [1-9]|[1-9][0-9]|[1-9][0-9][0-9]) roll 1 $1 ;;
     # If we get some other crazy input, show 'em the usage. 
     *) usage ;;
esac
