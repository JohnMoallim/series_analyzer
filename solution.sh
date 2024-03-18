#!/bin/bash

## GLOBAL VARIABLES
declare -a sorted

display_in_order(){
    echo "The list in the order it was entered: ${series[@]}"
}

display_sorted(){
    sort_series
    echo "The sorted list is: ${sorted[*]}"
}

find_max_value() {
    sort_series
    echo ${sorted[-1]}
}

find_min_value() {
    sort_series
    echo ${sorted[0]}
}

calculate_average() {
    local sum=0
    local count=${#series[@]}

    for num in "${series[@]}"; do
        ((sum+=num))
    done

    echo "scale=2; $sum / $count" | bc
}

sort_series() {
    sorted=($(for number in "${series[@]}"; do 
        echo "$number"; 
    done | sort -n))
}