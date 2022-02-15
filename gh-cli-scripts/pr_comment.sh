#!/bin/bash

# A simple script to retrive the open dependabot pr's from a repo,
# capture the pr number into an array and then loop over the list and
# and a comment on each with `@dependabot rebase`
#
# Created by me, @justin-irl on GitHub

###########################################################

prs=$( gh pr list --limit 100 )

declare -a pr_nums

for i in $prs
do
    [[ $i =~ ^[0-9]$ ]] && pr_nums+=( "$i" )
done

echo "Total open Dependabot PR's: ${#pr_nums[@]}"
echo ""

echo "Matching PR's:"
echo "$prs"
echo ""

echo "Do you want to issue a rebase comment to all these PR's?"
echo "Enter '1' to continue or anything else to abort:"
read -r -p ">>> " confirm
    if [[ "$confirm" =~ "1" ]]
    then
        for p in ${pr_nums[@]}
        do
            echo "Pr number: $p"
            gh pr comment $p --body "@dependabot rebase"
        done
    else
        exit 0
    fi