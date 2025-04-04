- vi analyze-one-dev.sh
- author="Jessica Castelino <js519934@dal.ca>"
output_file="java_analysis_temp/jessica_java_commits.txt"

- author="Bhumika Sharma <bhumikas30@gmail.com>"
output_file="java_analysis_temp/bhumika_java_commits.txt"


-author="Pedro H. Sambini da Silva <58950360+pedrohsambini@users.noreply.github.com>"


- author="FULL NAME <email@domain.com>"
echo "🔍 Checking files touched by: $author"

# Get commit hashes from author
commits=$(echo "$author" | ~/lookup/getValues a2c | cut -d ';' -f2- | tr ';' '\n' | sort -u)

# Extract file extensions touched by the commits
echo "$commits" | while read commit; do
  echo "$commit" | ~/lookup/getValues c2f | cut -d ';' -f2- | tr ';' '\n'
done | rev | cut -d. -f1 | rev | sort | uniq -c | sort -nr


check file
echo "f472cca059788f29c37d7dae85fdfe0272b26582" | ~/lookup/getValues c2f
echo "0db3434cd68f80c42159d80bc65f41db5e4df201" | ~/lookup/getValues c2f
check project
echo "f472cca059788f29c37d7dae85fdfe0272b26582" | ~/lookup/getValues c2p

