#!/bin/bash

display_in_order(){
	echo "The list in the order it was entered: ${series[@]}"
}

display_sorted(){
	local sorted=($(for number in "${series[@]}"; do 
						echo "$number"; 
						done | sort -n))
	
	echo "The sorted list is: ${sorted[*]}"
}
