#!/usr/bin/env bash

set -euo pipefail

DATABASE_URL="${DATABASE_URL}"

CURRENT_DATE=$(date +"%Y%m%d%H%M")
DUMP_FILE="db-dump-${CURRENT_DATE}.sql.gz"

echo "Creating dump at ${DUMP_FILE}"

if [[ -n "${USE_PGDUMPALL:-}" ]]; then
	export PGPASSWORD="$(echo "${DATABASE_URL}" | awk -F'[:@]' '{ print $3 }')"
	time pg_dumpall -d "${DATABASE_URL}" --no-role-passwords | gzip > "${DUMP_FILE}"
else
	time pg_dump -d "${DATABASE_URL}" | gzip > "${DUMP_FILE}"
fi

echo "Dump complete. Uploading..."

aws s3 cp $DUMP_FILE s3://$AWS_S3_BUCKET_NAME/$DUMP_FILE
