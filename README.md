# analyze_seco_timeline_myver
📚 Research Progress Report – Developer Timeline Analysis Using World of Code
Presented by: Hiruy Worku
Date: April 2, 2025

🔍 Project Objective
The goal of this project is to build a chronological timeline of software development activity for individual contributors in open source, filtered by programming language (e.g., Java). This timeline includes the first and last known commits made by a developer in a specific language, using data from the World of Code (WoC) dataset.

🧭 Research Plan (Today’s Agenda)
Start with a single developer, extract their commits.

Filter commits by programming language, beginning with Java.

Find the first and last commit timestamps for Java files.

Validate the developer, commit, and file data.

Package the logic into a reusable shell script.

Push the project to GitHub and document it properly.

🛠️ Tools Used
World of Code dataset (basemaps like a2c, c2f, etc.)

Lookup tool: getValues

Shell scripting (Bash)

Git & GitHub

Linux environment on da0 server

🧗 Challenges Faced & How We Solved Them
1. Developer Filtering
We started by scanning a large dataset of developer metadata to look for developers with potential contributions in Java. We ran this shell snippet to analyze each developer’s commit files:

bash
Copy
Edit
echo "$commits" | while read commit; do
  echo "$commit" | ~/lookup/getValues c2f | cut -d ';' -f2- | tr ';' '\n'
done | rev | cut -d. -f1 | rev | sort | uniq -c | sort -nr
2. Finding a Suitable Developer
We manually tested developers one by one. Many had commits but no .java files, or their commit hashes didn’t map to timestamps. After many failed candidates, we found:

✅ Jessica Castelino – Had extensive Java activity and valid data.

✅ Pedro Sambini – Had C file activity (used later for testing).

3. c2t Lookup Didn’t Work
We expected to use c2t (commit-to-timestamp) lookups, but we encountered:

bash
Copy
Edit
no map c2t
We verified that c2tFullHT files weren’t correctly linked. We searched the /da0_data/basemaps/ directory and discovered that the real files were named c2datFullR or c2taFullS instead.

We then tested:

bash
Copy
Edit
echo "<commit_hash>" | ~/lookup/getValues c2dat
And it worked perfectly, giving:

php-template
Copy
Edit
<commit_hash>;timestamp;timezone;author;project_hash
✅ Problem solved by switching from c2t → c2dat.

4. Commit Sorting and Timestamp Conversion
Once we had timestamps, we sorted them numerically and converted to readable form:

bash
Copy
Edit
date -d @<unix_timestamp>
5. Script Development
We turned the entire process into a shell script: analyze-one-dev.sh

Reads author email

Gets commit hashes

Filters Java file commits

Pulls timestamps from c2dat

Outputs first/last Java commit in human-readable time

6. Validation
We verified everything:

File types via c2f

Project name via c2p

Dates via c2dat

Jessica’s Java activity:

sql
Copy
Edit
🔵 First Commit: Mon Oct 15 2018
🔴 Last Commit: Sat Sep 21 2019
Files included:

MainActivity.java

UserDao.java, Reminder.java

DatabaseInitializer.java

Android resource files and Gradle config

7. GitHub Push
We encountered authentication issues pushing to a repo we were invited to. So instead:

✅ Created a new repo under Hiruy's account

✅ Cloned it and moved the script inside

✅ Committed and pushed the work successfully

📘 Documentation
We also wrote a clear README.md explaining:

Project goals

Dataset requirements

Script purpose

Example output

Future plans

🧠 Lessons Learned
Always verify the availability of lookup maps (e.g., c2t vs c2dat)

Not all developers have timestamped data — filtering is key

Building even a simple timeline requires integration of multiple mappings (a2c, c2f, c2dat, c2p)

Good documentation and modular scripting are essential for scaling to multiple developers

✅ Status as of Now
🎯 One developer's timeline extracted and validated (Jessica Castelino)

🧪 System tested on a second developer (Pedro Sambini)

💻 Script is working and versioned on GitHub

📄 Full documentation included

🔜 Ready to batch-process more developers and languages next

