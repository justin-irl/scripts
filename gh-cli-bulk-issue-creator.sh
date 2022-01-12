#!bin/bash

# A simple script to loop over an array of repo names and use
# the GitHub CLI tool to clone them, create, and populate issues
# with directions for people to carry out an action on their repo.
# Also creates a file to capture the repo name and url of
# the created issue.
#
# @justin-irl on GitHub

###########################################################

TITLE="My issue title"

# this will not expand vars
IFS='' read -r -d '' BODY <<'EOF'
This is the body of the issue.

```md
* Some markdown code blocked text.
```

Instructions:
* Step 1
* Step 2
EOF

# can also be gh username
ORG="my-org"

declare -a REPOS=( "repo-1" "repo-2" "repo-3" )

touch repo-issues.txt

for repo in "${REPOS[@]}"
do
  echo "$repo" >> repo-issues.txt
  gh repo clone "$ORG/$repo"
  cd $repo
  gh issue create --title "$TITLE" --body "$BODY" >> ../repo-issues.txt
  cd ..
  # optional: remove local repo copy after issue creation
  rm -rf $repo
done