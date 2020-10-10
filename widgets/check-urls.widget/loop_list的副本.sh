#!/bin/bash

echo "PROXY| "

export http_proxy=http://127.0.0.1:1080
export https_proxy=http://127.0.0.1:1080

while IFS= read -r line; do
  [ -z "$line" ] && continue
  [[ "$line" =~ ^#.*$ ]] && continue
  ./check-urls.widget/curl_check.sh $line
done < "$2"

echo "LOCAL| "

unset http_proxy
unset https_proxy

while IFS= read -r line; do
  [ -z "$line" ] && continue
  [[ "$line" =~ ^#.*$ ]] && continue
  ./check-urls.widget/curl_check.sh $line
done < "$1"