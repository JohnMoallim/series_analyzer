#!/bin/bash

## GLOBAL VARIABLES
declare -a sorted
declare -a series=()

# Main entry point of the script, handling menu and user interaction
main() {
    validate_first_entry "$@"

    while true; do
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

        #case start
        case "$choice" in
            a) input_series;;
            b) display_series_in_entered_order;;
            c) display_sorted_series;;
            d) display_max_value;;
            e) display_min_value;;
            f) calculate_average_value;;
            g) display_count;;
            h) display_sum;;
            i) exit_fun;;
            *) echo "invalid choice";;
        #end of case
        esac
    done

}

# Validates if a given input is a positive number
validate_numbers() {
	local re='^[0-9]+$'
	if ! [[ $1 =~ $re  ]]; then
		return 1
	fi 
	if [ $1 -le 0 ]; then
		return 1
	fi
	return 0
}	

# Validates all inputs to ensure they are positive numbers
validate_all(){
	for num in "$@"; do               
		if validate_numbers "$num"; then
			series+=("$num")
		else
			echo "Invalid arg: "$num""
			return 1
		fi
	done
	return 0
}

# Reads a series of positive numbers from the user
input_series() {
	series=()
	echo "Enter a series of positive numbers (at least 3, sepearated by spaces)"
	read -r -a series_input
	validate_all "${series_input[@]}" || return 1
}

# Validates the first entry when the script is executed with arguments
validate_first_entry(){
	if [ $# -ge 3 ]; then
		validate_all $@
	else 
		input_series
	fi
}

# Displays the series in the order it was entered
display_series_in_entered_order(){
    echo "The list in the order it was entered: ${series[@]}"
}

# Sorts and then displays the series
display_sorted_series(){
    sort_series
    echo "The sorted list is: ${sorted[*]}"
}

# Displays the maximum value in the series
display_max_value() {
    sort_series
    echo ${sorted[-1]}
}

# Displays the minimum value in the series
display_min_value() {
    sort_series
    echo ${sorted[0]}
}

# Calculates and displays the average value of the series
calculate_average_value() {
    local sum=0
    local count=${#series[@]}

    for num in "${series[@]}"; do
        ((sum+=num))
    done

    echo "scale=2; $sum / $count" | bc
}

# Helper function to sort the series
sort_series() {
    sorted=($(for number in "${series[@]}"; do 
        echo "$number"; 
    done | sort -n))
}

# Displays the number of elements in the series
display_count() {
    num_of_elements=${#series[@]}
    echo "The number of elements is: $num_of_elements"
}

# Calculates and displays the sum of the series
display_sum() {
    local sum=0
    for i in "${series[@]}"; do
        ((sum += i))
    done
    echo "The sum of the elements is: $sum"
}

# Exit function to properly exit the program
exit_fun() {
    exit 0
}

main "$@"