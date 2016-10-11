#!/bin/bash

chosen_cases=${1:-*}

cd /tests
echo "Running cases [$chosen_cases]"
cat ${chosen_cases}.cases | grep -v "^#" | xargs -L 1 -P 15 bash && (echo && echo All tests successfully passed. Congratulations!! Your are a great Engineer!) || (echo "Something went wrong, check your changes" && exit -1)