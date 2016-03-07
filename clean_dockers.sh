#!/bin/bash
if [[ "$OSTYPE"  == "linux-gnu" ]] 
then
	npm run clean-dockers-linux
else
	npm run clean-dockers-mac
fi