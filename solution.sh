#!/bin/bash

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
	local sorted=($(for number in "${series[@]}"; do 
						echo "$number"; 
						done | sort -n))
	
	echo "The sorted list is: ${sorted[*]}"
}
