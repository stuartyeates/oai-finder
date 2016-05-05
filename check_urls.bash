#!/bin/bash

mkdir -p ./logs
mkdir -p ./tmp

output=$(mktemp ./tmp/wget-output.XXXXXX)
success=./logs/goodurls-$$
failure=./logs/goodurls-$$

while read url
do
    echo ${url}
    wget 
    
done
