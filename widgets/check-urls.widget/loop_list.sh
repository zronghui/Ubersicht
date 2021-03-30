#!/bin/bash

echo $(date +"%T")'| ssr-1080'
# echo "PROXY| ssr-1080"

export http_proxy=http://127.0.0.1:1080
export https_proxy=http://127.0.0.1:1080

while IFS= read -r line; do
  [ -z "$line" ] && continue
  [[ "$line" =~ ^#.*$ ]] && continue
  ./check-urls.widget/curl_check.sh $line
done < "$2"

# date +"%T"
# echo "PROXY| v2ray-1087"
echo $(date +"%T")'| v2ray-1087'

export http_proxy=http://127.0.0.1:1087
export https_proxy=http://127.0.0.1:1087

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