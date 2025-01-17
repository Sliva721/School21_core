#!/bin/bash

source ./functions.sh

check_parameters "$@"

DIRECTORY="$1"
DIR_COUNT=$(count_directories "$DIRECTORY")
FILE_COUNT=$(count_files "$DIRECTORY")

measure_execution_time display_result "$DIRECTORY" "$DIR_COUNT" "$FILE_COUNT"