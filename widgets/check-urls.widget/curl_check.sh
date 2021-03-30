#!/bin/bash

if (($#)) ; then
     SERVER=$1
else
     SERVER=$(cat)
fi

STATUS=$(curl -L -s -o /dev/null -I -w "%{http_code}" $1 --connect-timeout 1.5)


if [ "${STATUS}" -eq "200" ]; then
    echo -e "$SERVER|online"
else
    echo -e "$SERVER|offline"
fi
