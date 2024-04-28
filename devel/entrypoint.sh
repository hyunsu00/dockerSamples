#!/usr/bin/env bash

echo "UNAME=${UNAME}, UID=${UID}, GID=${GID}, PUID=${PUID}, PGID=${PGID}"
sudo /user-mapping.sh ${UNAME} ${UID} ${GID} ${PUID} ${PGID}

exec "$@"
