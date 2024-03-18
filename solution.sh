#!/bin/bash

# Prints the number of elements in the series.
display_count() {
    num_of_elements=${#series[@]}
    echo "The number of elements is: $num_of_elements"
}

# Prints the sum of the numbers in the series.
display_sum() {
    local sum=0
    for i in "${series[@]}"; do
        ((sum += i))
    done
    echo "The sum of the elements is: $sum"
}

# Exit function, to exit the program proberly.
exit_fun() {
    exit 0
}
