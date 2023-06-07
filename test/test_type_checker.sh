#!/bin/bash

for file in test/test_data/*.rb; do
  filename=$(basename "$file" .rb)
  diff <(bundle exec srb tc --no-error-count --file "$file" 2>&1) "test/test_data/$filename.out"
  if [[ $? -ne 0 ]]; then
    fail=1
  fi
done

if [[ $fail == 1 ]]; then
  exit 1
fi
