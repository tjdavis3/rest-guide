#!/bin/sh
name=$1
title=$(grep -E "^# \w+" $1 | head -1 |  sed 's/^# //')
#title=$(echo "$title" | sed 's/^\*\*Status code\*\* //')

echo "---\ntitle: $title\n---\n$(cat $name)"  > $name
