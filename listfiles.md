# 📘 Script Explanation: `language_list_by_author.sh`

This script is designed to analyze the commit history of a specific developer and determine **which programming languages** they've contributed to based on the file extensions of files they've changed.

---

### 🔧 Script Breakdown

```bash
#!/bin/bash
```
This is the shebang line that tells the system to use the Bash shell to interpret the script.

```bash
author="Jessica Castelino <js519934@dal.ca>"
```
Specifies the developer whose contributions you want to analyze.

```bash
echo "📂 Languages contributed to by: $author"
```
Prints a friendly header message to clarify the purpose of the output.

```bash
commits=$(echo "$author" | ~/lookup/getValues a2c | cut -d ';' -f2- | tr ';' '\n' | sort -u)
```
- Uses the `getValues` tool with the `a2c` map to retrieve all commit hashes associated with the given author.
- `cut -d ';' -f2-`: Removes the author's name and keeps only the commit hashes.
- `tr ';' '\n'`: Translates semicolon-separated values into separate lines (i.e., one commit per line).
- `sort -u`: Ensures the commit list is unique and sorted.

```bash
echo "$commits" | while read commit; do
  echo "$commit" | ~/lookup/getValues c2f | cut -d ';' -f2- | tr ';' '\n'
done
```
- For each commit, it fetches the list of files modified in that commit using the `c2f` map.
- Then it parses the file list and splits each file into its own line.

```bash
| rev | cut -d. -f1 | rev | sort | uniq -c | sort -nr
```
This is a continuation of the previous pipeline:
- `rev | cut -d. -f1 | rev`: Extracts the file extension by reversing the filename, cutting by the first dot, and reversing again.
- `sort | uniq -c`: Counts the occurrences of each extension.
- `sort -nr`: Sorts results in descending order of frequency.

```bash
# Optional: Map extensions to programming languages manually (if needed)
```
You can extend the script to map file extensions (like `.java`, `.py`, `.js`) into specific languages for clearer output.

---

### ✅ Output Example
```bash
📂 Languages contributed to by: Jessica Castelino <js519934@dal.ca>
  29 java
  10 xml
   8 py
   5 js
   3 css
   2 html
   ...
```

You can use this information to generate a visual summary of which programming languages a developer has worked with, based purely on changed file extensions.
