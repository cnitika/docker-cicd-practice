#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p backups
FILE="backups/appdb_$(date +%F_%H-%M-%S).sql.gz"
docker compose exec -T db pg_dump -U appuser appdb | gzip > "$FILE"
ls -1t backups/appdb_*.sql.gz | tail -n +8 | xargs -r rm --
echo "Backup created: $FILE"
