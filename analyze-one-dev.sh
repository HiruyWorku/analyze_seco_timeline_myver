#!/bin/bash  # Shebang to specify the script should run with Bash

# CONFIGURATION
author="Jessica Castelino <js519934@dal.ca>"  # Set the developer's identity for analysis

echo "🔍 Analyzing Java commits for $author..."  # Informative message to show who we're analyzing

# Get commits by this author
commits=$(echo "$author" | ~/lookup/getValues a2c | cut -d ';' -f2- | tr ';' '\n' | sort -u)
# 1. Send the author's email to the a2c mapping to retrieve their commits
# 2. Cut off the first field (author name) using ';' as the delimiter
# 3. Transform semicolon-separated commit hashes into newline-separated lines
# 4. Sort and remove duplicates to get unique commit hashes

# Make temp directory
mkdir -p java_analysis_temp  # Create a directory to store temporary analysis results
output_file="java_analysis_temp/jessica_java_commits.txt"  # Define the output file path
> "$output_file"  # Truncate (empty) the output file if it already exists

# For each commit, check if it touched a .java file and has a valid timestamp
for commit in $commits; do  # Loop through each commit hash
  files=$(echo "$commit" | ~/lookup/getValues c2f)  # Get list of files changed in that commit
  echo "$files" | grep '\.java' &>/dev/null && {  # If any of those files end with .java
    dataline=$(echo "$commit" | ~/lookup/getValues c2dat)  # Get commit metadata (including timestamp)
    ts=$(echo "$dataline" | cut -d ';' -f2)  # Extract the UNIX timestamp field (2nd field)
    [[ $ts != no* && $ts != "" ]] && echo "$ts;$commit" >> "$output_file"  # If timestamp is valid, store it with the commit
  }
done

echo "✅ DONE"  # Finished processing commits
echo "-----------------------------"  # Visual separator

# Grab first + last by timestamp
first=$(sort "$output_file" | head -n 1)  # Get earliest commit (smallest timestamp)
last=$(sort "$output_file" | tail -n 1)   # Get latest commit (largest timestamp)

first_ts=$(echo "$first" | cut -d ';' -f1)  # Extract timestamp of first commit
first_hash=$(echo "$first" | cut -d ';' -f2)  # Extract hash of first commit
first_date=$(date -d "@$first_ts")  # Convert first timestamp to human-readable date

last_ts=$(echo "$last" | cut -d ';' -f1)  # Extract timestamp of last commit
last_hash=$(echo "$last" | cut -d ';' -f2)  # Extract hash of last commit
last_date=$(date -d "@$last_ts")  # Convert last timestamp to human-readable date

echo "🔵 First Java Commit:"  # Label for first commit
echo "  ⏱️ $first_date"  # Print date of first commit
echo "  🔑 $first_hash"  # Print hash of first commit

echo "🔴 Last Java Commit:"  # Label for last commit
echo "  ⏱️ $last_date"  # Print date of last commit
echo "  🔑 $last_hash"  # Print hash of last commit
echo "-----------------------------"  # End of output section
