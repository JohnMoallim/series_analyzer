#!/bin/bash

#return 0 (true) only if the input is a number and is positive
function validate() {
	local re='^[0-9]+$'
	if ! [[ $1 =~ $re  ]]; then
		return 1
	fi 
	if [ $1 -le 0 ]; then
		return 1
	fi
	return 0
}	


function validate_all(){
	for num in "$@"; do               
		if validate "$num"; then
			series+=("$num")
		else
			echo "Invalid arg: "$num""
			return 1
		fi
	done
	return 0
}

#reads the input and sends each argument to validation, if 
function input() {
	series=()
	echo "Enter a series of positive numbers (at least 3, sepearated by spaces)"
	read -r -a series_input
	validate_all $series_input || return 1
	return 0
}

#entry point, checks if the external arguments are 
function main(){
	if [ $# -ge 3 ]; then
		validate_all $@
	else 
		input 
	fi
}

