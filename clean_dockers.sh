#!/bin/bash
if [[ "$CIRCLECI" == "true" ]] 
then
	npm run clean-dockers-circleci
else
	npm run clean-dockers-mac
fi