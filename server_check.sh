#!/bin/sh

counter=0
max_attempts=10

while [ $counter -lt $max_attempts ]
do
    # command here
    curl -s 192.168.105.3:4444/api

    # Check the exit status
    if [ $? -eq 0 ]; then
        echo "Command succeeded"
        break
    fi

    # Increment the counter
    counter=$((counter+1))

    # Delay before the next attempt (optional)
    sleep 1
done

# Check if the maximum number of attempts was reached
if [ $counter -eq $max_attempts ]; then
    echo "Command failed after $max_attempts attempts"
    exit 1
fi