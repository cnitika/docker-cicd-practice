#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")"
REMOTE_USER="${1:?usage: transfer.sh user host [dest]}"
REMOTE_HOST="${2:?usage: transfer.sh user host [dest]}"
DEST="${3:-~/backups}"
scp backups/appdb_*.sql.gz "$REMOTE_USER@$REMOTE_HOST:$DEST/"
echo "Transferred to $REMOTE_USER@$REMOTE_HOST:$DEST"
