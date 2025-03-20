#!/bin/bash

JOBS_TO_CREATE=${1:-1}
# Check if JOBS_TO_CREATE environment variable is set
if [ -z "$JOBS_TO_CREATE" ]; then
  echo "Error: Environment variable JOBS_TO_CREATE is not set"
  exit 1
fi

# Check if JOBS_TO_CREATE is a valid number
if ! [[ "$JOBS_TO_CREATE" =~ ^[0-9]+$ ]]; then
  echo "Error: JOBS_TO_CREATE must be a positive integer"
  exit 1
fi

echo "Will loop $JOBS_TO_CREATE times"

# Loop from 1 to JOBS_TO_CREATE
for (( i=1; i<=$JOBS_TO_CREATE; i++ )); do
  echo "Iteration $i of $JOBS_TO_CREATE"
  
  # Create a job
cat <<- YAML | buildkite-agent pipeline upload
steps:
  - label: "Job $i"
    command: echo "Hello from Job $i .. sleeping for 5 seconds" && sleep 5
            
YAML 
  # Sleep for 1 second
  sleep 5
done

echo "Loop completed"