#!/bin/bash

## GLOBAL VARIABLES
declare -a sorted

input_series() 
{
    local series=()
    local num
    echo "enter a positive number or 'done' to finish"
    
    while read -r num && [[ "$num" != "done" ]]; do
        if [[ "$num" =~ ^[0-9]+$ && "$num" -gt 0 ]]; then
            series+=("$num")
        else
            echo "invalid input"
        fi
    done
    echo "${series[@]}"
}

main() {
    if [ $# -ge 3 ]; then
        series=("$@")
    else
        series=$(input_series)
    fi

    while true; do
        echo "working menu"
        echo "a. Input a Series"
        echo "b. Display the series in the order it was entered"
        echo "c. Display the series in sorted order"
        echo "d. Display the Max value of the series"
        echo "e. Display the Min value of the series"
        echo "f. Display the Average of the series"
        echo "g. Display the Number of elements in the series"
        echo "h. Display the Sum of the series"
        echo "i. Exit"

        read -r choice
        case "$choice" in
            a) series=$(input_series);;
            b) display_series;;
            c) display_sorted_series;;
            d) display_max;;
            e) display_min;;
            f) display_average;;
            g) display_count;;
            h) display_sum;;
            i) exit;;
            *) echo "invalid choice";;
        #end of case
        esac
    done

}

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
