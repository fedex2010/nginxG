#!/bin/bash

cd /tests
cat cases | grep -v "^#" | xargs -L 1 -P 5 bash && (echo && echo All tests successfully passed. Congratulations!! Your a great Engineer) || (echo "Something went wrong, check your changes" && exit -1)