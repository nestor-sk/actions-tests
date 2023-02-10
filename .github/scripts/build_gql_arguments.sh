#!/bin/bash
# Usage: bash build_gql_arguments.sh schema 1,schema 2 query 1,query 2 ignore 1,ignore 2
# Prints --schema "schema1" --schema "schema2" --ignore "ignore1" --ignore "ignore2" "query1" "query2"

set -f # disable globbing

schema_args=$(echo $1 | sed 's/,/ /g')
query_args=$(echo $2 | sed 's/,/ /g')
ignore_args=$(echo $3 | sed 's/,/ /g')

for schema in $schema_args; do
  echo -n "--schema \"$schema\" "
done

for ignore in $ignore_args; do
  echo -n "--ignore \"$ignore\" "
done

for query in $query_args; do
  echo -n "\"$query\" "
done

