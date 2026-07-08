#!/bin/bash

# FUNCTION CALL
name="Rabi"
age="19"
profession="student"
information(){
        echo "My name is $name. I am $age years old. I am a $profession"
}
information

#FUNCTION WITH PARAMETERS
great() {
        #LOCAL VARIABLES
        local name=$1
        local surname=$2
        local age=$3
        local city=$4
        echo "Hello, $name $surname. You are $age  years old and live in $city."
}
great " Rabi" "Sharma" 19 "Kathmandu"
