#!/bin/bash

# CONFIGURATION
author="Bhumika Sharma <bhumikas30@gmail.com>"

echo "🔍 Analyzing Java commits for $author..."

# Get commits by this author
commits=$(echo "$author" | ~/lookup/getValues a2c | cut -d ';' -f2- | tr ';' '\n' | sort -u)

# Make temp directory
mkdir -p java_analysis_temp
output_file="java_analysis_temp/jessica_java_commits.txt"
> "$output_file"  # Clear file

# For each commit, check if it touched a .java file and has a valid timestamp
for commit in $commits; do
  files=$(echo "$commit" | ~/lookup/getValues c2f)
  echo "$files" | grep '\.java' &>/dev/null && {
    dataline=$(echo "$commit" | ~/lookup/getValues c2dat)
    ts=$(echo "$dataline" | cut -d ';' -f2)
    [[ $ts != no* && $ts != "" ]] && echo "$ts;$commit" >> "$output_file"
  }
done

echo "✅ DONE"
echo "-----------------------------"

# Grab first + last by timestamp
first=$(sort "$output_file" | head -n 1)
last=$(sort "$output_file" | tail -n 1)

first_ts=$(echo "$first" | cut -d ';' -f1)
first_hash=$(echo "$first" | cut -d ';' -f2)
first_date=$(date -d "@$first_ts")

last_ts=$(echo "$last" | cut -d ';' -f1)
last_hash=$(echo "$last" | cut -d ';' -f2)
last_date=$(date -d "@$last_ts")

echo "🔵 First Java Commit:"
echo "  ⏱️ $first_date"
echo "  🔑 $first_hash"

echo "🔴 Last Java Commit:"
echo "  ⏱️ $last_date"
echo "  🔑 $last_hash"
echo "-----------------------------"

