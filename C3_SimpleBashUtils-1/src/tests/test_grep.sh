#!/bin/bash

# Define the test cases
FILES=("test1.txt" "test_large.txt")
FILES2=("test2.txt" "")
OPTIONS=("-e One" "-f templ.txt")
OPTIONS2=("-i" "-e Two" "" "-f templ.txt" "-v" "-c" "-l" "-n" "-h" "-s" "-iv" "-in")
OPTIONS3=("-i" "-v" "-c" "-l" "-n" "-h" "-s")

# Function to run a single test
run_test() {
    local option=$1
    local option2=$2
    local option3=$3
    local file=$4
    local file2=$5

    ../grep/s21_grep $option $option2 $option3 $file $file2 > test.out
    grep $option $option2 $option3 $file $file2 > ref.out
    diff ref.out test.out -q

    if [ $? -eq 0 ]; then
        echo "PASS: s21_grep $option $option2 $option3 $file $file2"
        return 0
    else
        echo "FAIL: s21_grep $option $option2 $option3 $file $file2"
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
                    if run_test "$option" "$option2" "$option3" "$file" "$file2"; then
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
