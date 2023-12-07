#!/bin/bash

is_prime() {
    num=$1
    if [ $num -le 1 ]; then
        return 1
    fi

    for ((i=2; i*i<=num; i++)); do
        if [ $((num % i)) -eq 0 ]; then
            return 1
        fi
    done
    return 0
}

print_primes_in_range() {
    start=$1
    end=$2
    primes=()
    for ((num=start; num<=end; num++)); do
        if is_prime $num; then
            primes+=($num)
        fi
    done
    echo "${primes[@]}"
}

# Example usage:
start_range=100
end_range=150
echo "Prime numbers between $start_range and $end_range:"
print_primes_in_range $start_range $end_range

