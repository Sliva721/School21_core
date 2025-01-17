#!/bin/bash

# checking the number of arguments
if [ $# != 1 ]; 
then
    echo "Error: requires one non-numeric argument"
exit 1
fi

# checking arguments for a number
if [[ "$1" =~ ^[-+]?[0-9]+([.,][0-9]+)?$ ]]; then
    echo "Error: requires non-numeric argument"
else
    echo "The value of the argument: $1"
fi

