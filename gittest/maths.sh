#!/bin/bash

# Check the number of arguments
if [ $# -lt 3 ]; then
  echo "Usage: $0 <number1> <operator> <number2> [number3] [number4] ..."
  exit 1
fi

# Assign the first three arguments to variables
number1=$1
operator=$2
number2=$3

# Perform the math operation based on the operator
case "$operator" in
  "+")
    result=$(($number1 + $number2))
    ;;
  "-")
    result=$(($number1 - $number2))
    ;;
  "*")
    result=$(($number1 * $number2))
    ;;
  "/")
    result=$(($number1 / $number2))
    ;;
  *)
    echo "Invalid operator: $operator"
    exit 1
    ;;
esac

# Process additional numbers
if [ $# -gt 3 ]; then
  shift 3 # Shift the arguments to remove the first three
  for num in "$@"; do
    result=$(($result $operator $num))
  done
fi

# Print the result
echo "Result: $result"
