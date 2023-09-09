#!/bin/bash

gh repo list code-423n4 --limit 1000 --json name -q '.[] | select((.name | test("^[0-9]{4}")) and (.name | endswith("-findings") | not))' > repos.json

jq -r '.name' repos.json | while read -r repo_name; do
    # Check if the directory with the repo name exists
    if [[ ! -d "$repo_name" ]]; then
        # Clone the repo if it doesn't exist
        gh repo clone "code-423n4/$repo_name"
    else
        echo "Repo $repo_name already exists in the current folder."
    fi
done
