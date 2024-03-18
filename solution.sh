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

