#!/bin/sh
set -eu
rsync -a --delete /data/source/ /data/replica/
echo "$(date '+%F %T') sync done"
