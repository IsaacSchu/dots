#!/bin/bash
if [ -z "$1" ];
then
	color="cyan"
else
	color="$1"
fi
if [ -z "$2" ];
then  
        speed="94"
else 
	speed="$2"
fi
unimatrix -c "$color" -s "$speed"
