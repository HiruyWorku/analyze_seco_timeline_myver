# 📄 Script: language_fingerprints.sh

This script checks if a given developer has ever touched files in various programming languages. It prints 1 if the author has modified a file in that language and 0 otherwise.

---

```bash
#!/bin/bash
author="Jessica Castelino <js519934@dal.ca>"
echo ""
echo " Language fingerprint for: $author"
echo "--------------------------------------"
```
- Sets the target developer and prints a heading.

---

```bash
commits=$(echo "$author" | ~/lookup/getValues a2c | cut -d ';' -f2- | tr ';' '\n' | sort -u)
```
- Gets all commit hashes associated with the developer using `a2c`.

---

```bash
echo "🔎 Showing first 5 commits for debugging..."
echo "$commits" | head -n 5
```
- Prints first few commits for debug purposes.

---

```bash
first_commit=$(echo "$commits" | head -n 1)
echo ""
echo "🔎 Files in first commit:"
files=$(echo "$first_commit" | ~/lookup/getValues c2f | cut -d ';' -f2- | tr ';' '\n')
echo "$files"
```
- Displays files changed in the first commit for verification.

---

```bash
for lang in JavaScript HTML/CSS Python SQL TypeScript Bash/Shell Java C# C++ C; do
```
- Loops through each language we are checking.

```bash
  case $lang in
    JavaScript)   match="\.js$" ;;
    HTML/CSS)     match="\.html$|\.css$" ;;
    Python)       match="\.py$" ;;
    SQL)          match="\.sql$" ;;
    TypeScript)   match="\.ts$" ;;
    Bash/Shell)   match="\.sh$|\.bash$" ;;
    Java)         match="\.java$" ;;
    C#)           match="\.cs$" ;;
    C++)          match="\.cpp$|\.cc$|\.cxx$" ;;
    C)            match="\.c$" ;;
  esac
```
- Defines regex patterns for file extensions per language.

```bash
  found=$(echo "$commits" | while read commit; do
    echo "$commit" | ~/lookup/getValues c2f | cut -d ';' -f2- | tr ';' '\n'
  done | grep -E "$match" | head -n 1)

  [[ -n $found ]] && echo "$lang: 1" || echo "$lang: 0"
done
```
- Checks all commits for the presence of files that match the language extension pattern.
- Prints `1` if found, otherwise `0`.

---

```bash
echo "--------------------------------------"
```
- Ends the fingerprint summary with a line.
