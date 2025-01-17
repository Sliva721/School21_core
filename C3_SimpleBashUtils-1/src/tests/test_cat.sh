#!/bin/bash

# Define the test cases
FILES=("test1.txt")
FILES2=("" "test3.txt" "test2.txt" "test1.txt")
OPTIONS=("-b" "-e" "-n" "-s" "-t" "-v" "-E" "-T" "--number-nonblank" "--number" "--squeeze-blank")
OPTIONS2=("--number-nonblank" "--number" "--squeeze-blank" "" "-b" "-e" "-n" "-s" "-t" "-v" "-E" "-T" )
OPTIONS3=("")

# Function to run a single test
run_test() {
    local file=$1
    local file2=$2
    local option=$3
    local option2=$4
    local option3=$5
    ../cat/s21_cat $option $option2 $option3 $file $file2 > test.out
    cat $option $option2 $option3 $file $file2 > ref.out
    diff ref.out test.out -q

    if [ $? -eq 0 ]; then
        echo "PASS: s21_cat $option $option2 $option3 $file $file2"
        return 0
    else
        echo "FAIL: s21_cat $option $option2 $option3 $file $file2"
        return 1
    fi
}

# Summary variables
total_tests=0
passed_tests=0
failed_tests=0

# Run all tests
for file in "${FILES[@]}"; do
    for file2 in "${FILES2[@]}"; do
        for option in "${OPTIONS[@]}"; do
            for option2 in "${OPTIONS2[@]}"; do
                for option3 in "${OPTIONS3[@]}"; do
                    total_tests=$((total_tests + 1))
                    if run_test "$file" "$file2" "$option" "$option2" "$option3"; then
                        passed_tests=$((passed_tests + 1))
                    else
                        failed_tests=$((failed_tests + 1))
                    fi
                done
            done
        done
    done
done

# Summary report
echo
echo "Total tests: $total_tests"
echo "Passed tests: $passed_tests"
echo "Failed tests: $failed_tests"

# Exit with the number of failed tests as the status code
exit $failed_tests
