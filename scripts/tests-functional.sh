#!/bin/bash

readonly DIR="$(realpath $(dirname ${BASH_SOURCE[0]}))"
readonly COMMANDS=( checkContainer checkImage deploy pull rm run stop )

for command in "${COMMANDS[@]}"; do
    echo "-------------------------------------------------"
    echo "| Executing functional tests for ${command}     |"
    echo "-------------------------------------------------"
    $DIR/tests-${command}.sh
done