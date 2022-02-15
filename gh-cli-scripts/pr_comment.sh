#!/bin/bash

# A simple script to retrive the open dependabot pr's from a repo,
# capture the pr number into an array and then loop over the list and
# and a comment on each with `@dependabot rebase`
#
# Created by me, @justin-irl on GitHub

###########################################################

# change to filter on open pr's
# best to use part of a branch name or pr title
# eg: 'dependabot' or 'Bump'
serchterm="branch"
# change to what you want to comment on the pr
prcomment="comment"

prs=$( gh pr list --limit 100 | grep "$searchterm" )

declare -a pr_nums

for i in $prs
do
    [[ $i =~ ^[0-9]$ ]] && pr_nums+=( "$i" )
done

echo "Total open matching PR's: ${#pr_nums[@]}"
echo ""

echo "Matching PR's:"
echo "$prs"
echo ""

echo "Do you want to issue a comment to all these PR's?"
echo "Enter '1' to continue or anything else to abort:"
read -r -p ">>> " confirm
    if [[ "$confirm" =~ "1" ]]
    then
        for p in ${pr_nums[@]}
        do
            echo "Pr number: $p"
            gh pr comment $p --body "$prcomment"
        done
    else
        exit 0
    fi