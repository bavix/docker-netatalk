#!/bin/bash
[[ $(ps aux | grep '[n]etatalk -d\|[a]vahi-daemon' | wc -l) -ge '2' ]]
exit $?
