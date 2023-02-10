#!/bin/bash
# Usage: bash build_gql_arguments.sh 'schema 1','schema 2' 'query 1','query 2' 'ignore 1','ignore 2'
# Prints --schema schema1 --schema schema2 --ignore ignore1 --ignore ignore2 query1 query2

set -f # disable globbing

schema_args=$(echo $1 | sed 's/,/ --schema /g')
query_args=$(echo $2 | sed 's/,/ /g')
ignore_args=$(echo $3 | sed 's/,/ --ignore /g')

if [ -z "$ignore_args" ]; then
    ignore_args=""
else
    ignore_args="--ignore $ignore_args"
fi

echo "--schema $schema_args $ignore_args $query_args"



