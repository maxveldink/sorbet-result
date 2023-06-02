#!/bin/bash

for file in test/test_data/*.rb; do
  filename=$(basename "$file" .rb)
  diff <(bundle exec srb tc --no-error-count --file "$file" 2>&1) "test/test_data/$filename.out"
done
