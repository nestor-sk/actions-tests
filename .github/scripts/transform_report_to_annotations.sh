#!/bin/bash
# This script is used to transform the lint.json to annotations.json
# The lint.json is the output of the lint tool
# The modified.json is a json array with paths of modified files from the pull request
# The annotations.json is the output of the script

# Usage: bash transform.sh lint.json modified.json > annotations.json

IFS=$'\n'
lint_json_file=$1
modified_json_file=$2

lint_json=$(cat $lint_json_file | jq -c '.[]')
modified_json=$(cat $modified_json_file | jq -cr '.[]')
output_json='[]'

# this is O(n^2) but it's fine for our use case
for lint in $lint_json; do
    lint_file_path=$(echo $lint | jq -r '.file')
  for modified_file_path in $modified_json; do
    if [ "$lint_file_path" = "$modified_file_path" ]; then
        new_entry=$(echo $lint | jq -c '. | { "file": .file, "line": .line, "title": "\(.field) is deprecated", "message": .reason, "annotation_level": "warning" }')
        output_json=$(echo $output_json | jq -c ". + [$new_entry]")
    fi
  done
done

echo $output_json